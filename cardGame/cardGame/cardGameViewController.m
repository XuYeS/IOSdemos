//
//  cardGameViewController.m
//  cardGame
//
//  Created by 徐烨晟 on 16-3-28.
//  Copyright (c) 2016年 ___FULLUSERNAME___. All rights reserved.
//

#import "cardGameViewController.h"
#import "Deck.h"
#import "Card.h"
#import "playCard.h"
#import "cardMatchingGame.h"
@interface cardGameViewController ()

@property (nonatomic,strong)Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLable;
@property (nonatomic,strong)cardMatchingGame *game;
@end

@implementation cardGameViewController

-(Deck*)creatDeck{
    return nil;
}

-(Deck*)deck
{
    if (!_deck) {
        _deck=[self creatDeck];
    }
    return _deck;
}

-(cardMatchingGame *)game
{
    if (!_game) {
        _game=[[cardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                               usingDeck:[self creatDeck]];
    }
    return _game;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex=[self.cardButtons indexOfObject:sender];
    [self.game  chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
     self.ScoreLable.text=[NSString stringWithFormat:@"Score:%ld",(long)self.game.score];
    
}
-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex=[self.cardButtons indexOfObject:cardButton];
        Card *card=[self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled=!card.isMatched;
    }
}


-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.content : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
@end
