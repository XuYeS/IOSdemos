//
//  BezierPathView.m
//  dropGame
//
//  Created by 徐烨晟 on 16-4-6.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

-(void)setPath:(UIBezierPath *)path
{
    _path=path;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.path stroke];
}


@end
