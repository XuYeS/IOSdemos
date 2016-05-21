//
//  cardMatchingGame.h
//  cardGame
//
//  Created by 徐烨晟 on 16-3-30.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
@interface cardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)Index;
-(Card *)cardAtIndex:(NSUInteger)Index;

@property(nonatomic,readonly)NSInteger score;
@end
