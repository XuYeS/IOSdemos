//
//  Card.m
//  cardGame
//
//  Created by 徐烨晟 on 16-3-29.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int sorce = 0;
    for (Card *card in  otherCards) {
        [card.content isEqualToString:self.content];
        sorce=1;
    }
    return sorce;
}


@end
