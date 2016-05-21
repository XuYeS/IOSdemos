//
//  playCardDeck.m
//  cardGame
//
//  Created by 徐烨晟 on 16-3-29.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "playCardDeck.h"

@implementation playCardDeck

-(instancetype)init
{
    self=[super init];
    if (self) {
        for(NSString *suit in [playCard validSuits])
        {
            for (NSUInteger rank=1; rank<=[playCard maxRank]; rank++) {
                playCard *card = [[playCard alloc]init];
                card.suit=suit;
                card.rank=rank;
                [self cardAdd:card];
            }
        }
    }
    return self;
}

@end
