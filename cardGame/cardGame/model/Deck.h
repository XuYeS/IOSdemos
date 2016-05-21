//
//  Deck.h
//  cardGame
//
//  Created by 徐烨晟 on 16-3-29.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
-(void)cardAdd:(Card *)card atTop:(BOOL)atTop;
-(void)cardAdd:(Card *)card;

-(Card *)drawRandomCards;
@end
