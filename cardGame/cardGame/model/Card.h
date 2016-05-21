//
//  Card.h
//  cardGame
//
//  Created by 徐烨晟 on 16-3-29.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(nonatomic,strong)NSString *content;
@property(nonatomic,getter=isChosen)BOOL chosen;
@property(nonatomic,getter = isMatched)BOOL matched;

-(int)match:(NSArray*)otherCards;
@end
