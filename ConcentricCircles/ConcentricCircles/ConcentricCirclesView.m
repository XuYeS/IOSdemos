//
//  ConcentricCirclesView.m
//  ConcentricCircles
//
//  Created by 徐烨晟 on 16-4-8.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "ConcentricCirclesView.h"
@interface ConcentricCirclesView()
@property (strong,nonatomic)UIColor *circleColor;


@end
@implementation ConcentricCirclesView



-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor=circleColor;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    
    CGPoint center;
    center.x=self.bounds.origin.x+self.bounds.size.width/2.0;
    center.y=self.bounds.origin.y+self.bounds.size.height/2.0;
  //  CGFloat width =self.bounds.size.width/2.0;
 //   CGFloat height = self.bounds.size.height/2.0;
    //CGFloat radius=MIN(width, height);
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    
    
    path.lineWidth=10.0;
    [self.circleColor setStroke];
    
    for (CGFloat currentRadius = self.bounds.size.height; currentRadius>0; currentRadius-=20) {
        
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI*2.0 clockwise:YES];
        
    }
    
    [path stroke];
    
   // [[UIImage imageNamed:@"cardBack"] drawInRect:CGRectMake(center.x-10,center.y-15, 20, 30)];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%@ was touched",self);
    CGFloat red=(arc4random()%100)/100.0;
    CGFloat green=(arc4random()%100)/100.0;
    CGFloat blue=(arc4random()%100)/100.0;
    
    UIColor *radomColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor=radomColor;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor=[UIColor whiteColor];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
