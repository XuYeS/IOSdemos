//
//  Deck.m
//  cardGame
//
//  Created by 徐烨晟 on 16-3-29.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property(nonatomic,strong)NSMutableArray *cards;
@end

@implementation Deck

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards=[[NSMutableArray alloc] init];
    }
    return _cards;
}
-(void)cardAdd:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}



-(void)cardAdd:(Card *)card
{
    [self cardAdd:card atTop:NO];
}

-(Card *)drawRandomCards
{
    Card * radomCard=nil;
    if ([self.cards count]) {
        unsigned index=arc4random()%[self.cards count];
        radomCard=self.cards[index];
        [self.cards removeObject:radomCard];
    }
    return radomCard;
}

@end
