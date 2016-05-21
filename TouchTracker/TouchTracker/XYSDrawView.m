//
//  XYSDrawView.m
//  TouchTracker
//
//  Created by 徐烨晟 on 16-4-12.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSDrawView.h"
#import "XYSLine.h"
@interface XYSDrawView()<UIGestureRecognizerDelegate>

//@property (strong,nonatomic)XYSLine *currentLine;
@property (strong,nonatomic)UIGestureRecognizer *moveRecognizer;//if not pan and longpress may can't work together
@property (strong,nonatomic)NSMutableDictionary *linesInProcess;
@property (strong,nonatomic)NSMutableArray *finishLines;
@property (weak,nonatomic)XYSLine *selectLine;
@end
@implementation XYSDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProcess=[[NSMutableDictionary alloc]init];
        self.finishLines=[[NSMutableArray alloc]init];
        self.backgroundColor=[UIColor grayColor];
        self.multipleTouchEnabled=YES;
        
        UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(removeAllLines:)];
        doubleTap.numberOfTapsRequired=2;
        doubleTap.delaysTouchesBegan=YES;//if it is NO,when you double tap you can see a small red dot
        [self addGestureRecognizer:doubleTap];
        
        
        UITapGestureRecognizer *oneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTap:)];
        oneTap.delaysTouchesBegan=YES;
        [oneTap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:oneTap];
        
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.delaysTouchesBegan=YES;
        [self addGestureRecognizer:longPress];
        
        self.moveRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLine:)];
        self.moveRecognizer.delegate=self;
        self.moveRecognizer.cancelsTouchesInView=NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
    }
    return self;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    UIMenuController *menuController=[UIMenuController sharedMenuController];
    if (gestureRecognizer==self.moveRecognizer&&!menuController.menuItems) {
        return YES;
    }
    return NO;
}
-(void)panLine:(UIPanGestureRecognizer *)pgr
{
    if (!self.selectLine) {
        return;
    }
    if (pgr.state==UIGestureRecognizerStateChanged) {
        CGPoint translation=[pgr translationInView:self];
        CGPoint begin=self.selectLine.begin;
        CGPoint end=self.selectLine.end;
        begin.x+=translation.x;
        begin.y+=translation.y;
        
        end.x+=translation.x;
        end.y+=translation.y;
        
        
        self.selectLine.begin=begin;
        self.selectLine.end=end;
        [self setNeedsDisplay];
        [pgr setTranslation:CGPointZero inView:self];//if no the begin and end will add up x and y,and the line will fly away!!
        
    }
    
    
    
}
-(void)longPress:(UILongPressGestureRecognizer *)lpgr
{
    if (lpgr.state ==UIGestureRecognizerStateBegan) {
        CGPoint point=[lpgr locationInView:self];
        self.selectLine=[self lineAtPoint:point];
        
        if (self.selectLine) {
            [self.linesInProcess removeAllObjects];
        }
    }
    else if (lpgr.state==UIGestureRecognizerStateEnded)
    {
        self.selectLine=nil;
    }
    
    [self setNeedsDisplay];
    
}
-(void)removeAllLines:(UITapGestureRecognizer*)tgr
{
    [self.linesInProcess removeAllObjects];
    [self.finishLines removeAllObjects];
    
    [self setNeedsDisplay];
}
-(XYSLine *)lineAtPoint:(CGPoint)point
{
    for (XYSLine *line in self.finishLines) {
        CGPoint begin=line.begin;
        CGPoint end=line.end;
        
        for (float t=0.0; t<1.0; t+=0.05) {
            float x=begin.x+t*(end.x-begin.x);
            float y=begin.y+t*(end.y-begin.y);
            
            if (hypot(x-point.x, y-point.y)<20) {//hypot 计算直角三角形的斜边长, also distance for two points
                return line;
            }
        }
    }
    return nil;
}
-(void)deleteLine:(id)sender
{
    [self.finishLines removeObject:self.selectLine];
    [self setNeedsDisplay];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(void)oneTap:(UITapGestureRecognizer *)tgr
{
    CGPoint point=[tgr locationInView:self];
    self.selectLine=[self lineAtPoint:point];
    
    if (self.selectLine) {
        [self becomeFirstResponder];
        
        UIMenuController *menuController=[UIMenuController sharedMenuController];
        
        UIMenuItem *delete=[[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menuController.menuItems=@[delete];
        
        [menuController setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menuController setMenuVisible:YES animated:YES];
        
    }
    else
    {
        [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location=[touch locationInView:self];
        XYSLine *line =[[XYSLine alloc]init];
        line.begin=location;
        line.end=location;
        NSValue *key=[NSValue valueWithNonretainedObject:touch];
        
        [self.linesInProcess setObject:line forKey:key];
    }
    [self setNeedsDisplay];//setNeedsDisplay can use drawRect!
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:touch];
        XYSLine *line=[self.linesInProcess objectForKey:key];
        CGPoint location=[touch locationInView:self];
        line.end=location;
    }

    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:touch];
        XYSLine *line=[self.linesInProcess objectForKey:key];
        CGPoint location=[touch locationInView:self];
        line.end=location;
        [self.finishLines addObject:line];
        [self.linesInProcess removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
-(void)strokeLine:(XYSLine *)Line
{
    UIBezierPath *bezierPath=[[UIBezierPath alloc]init];
    bezierPath.lineWidth=10;
    bezierPath.lineCapStyle=kCGLineCapRound;
    
    [bezierPath moveToPoint:Line.begin];
    [bezierPath addLineToPoint:Line.end];
    
    [bezierPath stroke];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    // Drawing code
    [[UIColor blackColor]set];
    for (XYSLine *Line in self.finishLines) {
        [self strokeLine:Line];
    }
    
    [[UIColor redColor]set];
    for (NSValue *key in self.linesInProcess) {
        self.selectLine=nil;
        UIMenuController *menuController=[UIMenuController sharedMenuController];
        [menuController setMenuVisible:NO animated:YES];
        [self strokeLine:self.linesInProcess[key]];
    }
    
    if (self.selectLine) {
        [[UIColor greenColor]set];
        [self strokeLine:self.selectLine];
    }
    
}


@end
