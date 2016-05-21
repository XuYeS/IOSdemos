//
//  dropGameBehavior.m
//  dropGame
//
//  Created by 徐烨晟 on 16-4-6.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "dropGameBehavior.h"

@interface dropGameBehavior()

@property (strong,nonatomic)UIGravityBehavior *gravity;
@property (strong,nonatomic)UICollisionBehavior *collider;
@property (strong,nonatomic)UIDynamicItemBehavior *animatorOptions;
@end
@implementation dropGameBehavior


-(instancetype)init
{
    self=[super init];
    if(self)
    {
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collider];
        [self addChildBehavior:self.animatorOptions];
    }
    
    return self;
}

-(UIGravityBehavior*)gravity
{
    if (!_gravity) {
        _gravity=[[UIGravityBehavior alloc]init];
        _gravity.magnitude=0.8;
    }
    return _gravity;
}

-(UICollisionBehavior*)collider
{
    if (!_collider) {
        _collider=[[UICollisionBehavior alloc]init];
        _collider.translatesReferenceBoundsIntoBoundary=YES;
    }
    return _collider;
}

-(UIDynamicItemBehavior*)animatorOptions
{
    if (!_animatorOptions) {
       _animatorOptions=[[UIDynamicItemBehavior alloc]init];
        _animatorOptions.allowsRotation=NO;
    }
    return _animatorOptions;
}
-(void)addItem:(id<UIDynamicItem>)Item
{
    [self.gravity addItem:Item];
    [self.collider addItem:Item];
    [self.animatorOptions addItem:Item];
}
-(void)removeItem:(id<UIDynamicItem>)Item
{
    [self.gravity removeItem:Item];
    [self.collider removeItem:Item];
    [self.animatorOptions removeItem:Item];
}

@end
