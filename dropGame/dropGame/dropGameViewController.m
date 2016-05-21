//
//  dropGameViewController.m
//  dropGame
//
//  Created by 徐烨晟 on 16-4-6.
//  Copyright (c) 2016年 ___FULLUSERNAME___. All rights reserved.
//

#import "dropGameViewController.h"
#import "dropGameBehavior.h"
#import "BezierPathView.h"
@interface dropGameViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property (strong,nonatomic)UIDynamicAnimator *animator;
@property (strong,nonatomic)dropGameBehavior *dropBehavior;
@property (strong,nonatomic)UIAttachmentBehavior *attachment;
@property (strong,nonatomic)UIView *droppingView;
@end

@implementation dropGameViewController

static const CGSize DROP_SIZE ={40,40};

#pragma mark -lazyInstantiation

-(UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

-(dropGameBehavior *)dropBehavior
{
    if (!_dropBehavior) {
        _dropBehavior=[[dropGameBehavior alloc]init];
        [self.animator addBehavior:_dropBehavior];
    }
    return _dropBehavior;
}

#pragma mark -methods
- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    [self drop];
}
- (IBAction)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    if (sender.state==UIGestureRecognizerStateBegan)
    {
        [self attechDroppingViewToPoint:gesturePoint];
    }
    else if (sender.state==UIGestureRecognizerStateChanged)
    {
        self.attachment.anchorPoint=gesturePoint;
    }
    else if (sender.state==UIGestureRecognizerStateEnded)
    {
        [self.animator removeBehavior:self.attachment];
        self.gameView.path=nil;
    }
}

-(void)attechDroppingViewToPoint:(CGPoint)anchorPoint
{
    if (self.droppingView) {
        self.attachment =[[UIAttachmentBehavior alloc]initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        __weak dropGameViewController *weakSelf=self;
        UIView *dropppingView = self.droppingView;//important !because self.droppingView=nil after block,but the things in block get reevaluated every time
        self.attachment.action=^{
            UIBezierPath *path =[[UIBezierPath alloc]init];
            [path moveToPoint:weakSelf.attachment.anchorPoint];//can't use anchorPoint,because I'm changing anchorPoint,every time I move that pan.
                                                            //but the anchorPoint is the I first attached it
            [path addLineToPoint:dropppingView.center];
            weakSelf.gameView.path=path;
        };
        self.droppingView=nil;
        [self.animator addBehavior:self.attachment];
    }
}

-(void)drop
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size =DROP_SIZE;
    int x =(arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x=x * DROP_SIZE.width;
    
    UIView *dropView=[[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    
    [self.gameView addSubview:dropView];
    self.droppingView=dropView;
    [self.dropBehavior addItem:dropView];
    
}
-(UIColor*)randomColor
{
    switch (arc4random()%5) {
        case 0:
            return [UIColor brownColor];
            break;
        case 1:
            return [UIColor redColor];
            break;
        case 2:
            return [UIColor blueColor];
            break;
        case 3:
            return [UIColor purpleColor];
            break;
        case 4:
            return [UIColor orangeColor];
            break;
        default:
            break;
    }
    return [UIColor redColor];
}
-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator//method from delegate
{
    [self removeCompletedRow];
}

-(BOOL)removeCompletedRow
{
    NSMutableArray *dropsToRemove=[[NSMutableArray alloc]init];
    for (CGFloat y=self.gameView.bounds.size.height-DROP_SIZE.height/2; y>0 ; y-=DROP_SIZE.height)
    {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound=[[NSMutableArray alloc]init];
        for (CGFloat x=DROP_SIZE.width/2; x<=self.gameView.bounds.size.width-DROP_SIZE.width/2; x+=DROP_SIZE.width)
        {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if ([hitView superview]==self.gameView) {
                [dropsFound addObject:hitView];
                
            }
            else
            {
                rowIsComplete=NO;
                break;
            }
            
        }
        if (![dropsFound count]) {
            break;
        }
        if (rowIsComplete) {
            [dropsToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if ([dropsToRemove count]) {
        for (UIView *drop in dropsToRemove) {
            [self.dropBehavior removeItem:drop];
        }
    }
    [self animateRemovingDrops:dropsToRemove];
    
    return NO;
}

-(void)animateRemovingDrops:(NSArray *)dropsToRemove
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *drop in dropsToRemove) {
                             int x=(arc4random()%(int)(self.gameView.bounds.size.width*5))-(self.gameView.bounds.size.width*2);
                             int y=self.gameView.bounds.size.height;
                             drop.center=CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished){
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
