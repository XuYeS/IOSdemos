//
//  dropGameBehavior.h
//  dropGame
//
//  Created by 徐烨晟 on 16-4-6.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dropGameBehavior : UIDynamicBehavior

-(void)addItem:(id <UIDynamicItem>)Item;
-(void)removeItem:(id <UIDynamicItem>)Item;

@end
