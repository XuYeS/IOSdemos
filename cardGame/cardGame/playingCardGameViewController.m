//
//  playingCardGameViewController.m
//  cardGame
//
//  Created by 徐烨晟 on 16-4-3.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "playingCardGameViewController.h"
#import "playCardDeck.h"
@interface playingCardGameViewController ()

@end

@implementation playingCardGameViewController
-(Deck *)creatDeck
{
    return [[playCardDeck alloc]init];
}

@end
