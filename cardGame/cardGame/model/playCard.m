//
//  playCard.m
//  cardGame
//
//  Created by 徐烨晟 on 16-3-29.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "playCard.h"

@implementation playCard
@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];

}
+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    playCard *otherCard=[otherCards firstObject];
    
    if ([self.suit isEqualToString:otherCard.suit]) {
        score=4;
    }
    else if(self.rank==otherCard.rank)
    {
        score=1;
    }
    return  score;
}

- (NSString *)content
{
    return [[playCard rankStrings][self.rank] stringByAppendingString:self.suit];
}


- (void)setSuit:(NSString *)suit
{
    if ([[playCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}







@end
