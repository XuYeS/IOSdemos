//
//  cardMatchingGame.m
//  cardGame
//
//  Created by 徐烨晟 on 16-3-30.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "cardMatchingGame.h"

@interface cardMatchingGame()
@property(nonatomic,readwrite)NSInteger score;
@property(nonatomic,strong)NSMutableArray * cards;//of Card

@end


@implementation cardMatchingGame
-(NSMutableArray*)cards
{
    if (!_cards) {
        _cards=[[NSMutableArray alloc]init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self=[super init];
    if (self) {
        for (int i=0; i<count; i++) {
            Card * card=[deck drawRandomCards];
            if (card) {
                [self.cards addObject:card];
                 //NSLog(@"%d\n",[self.cards count]);
            }else{
                self=nil;
                break;
            }
        }
    }
    return self;
}
-(void)chooseCardAtIndex:(NSUInteger)Index
{
    Card * card=[self cardAtIndex:Index];

    if (!card.isMatched) {
        if (card.isChosen)
        {
            card.chosen=NO;
        }
        else
        {
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchCard=[card match:@[otherCard]];
                    if(matchCard)
                    {
                        self.score+=4;
                        otherCard.matched=YES;
                        card.matched=YES;
                    }
                    else
                    {
                        self.score-=2;
                        otherCard.chosen=NO;
                    }
                    break;
                }
            }
            self.score-=1;
            card.chosen=YES;
        }
    }
}
-(Card*)cardAtIndex:(NSUInteger)Index
{
   // NSLog(@"%d\n",[self.cards count]);
    if (Index<[self.cards count]) {
        return [self.cards objectAtIndex:Index];
    }
    else
    {
        return nil;
    }
}


@end
