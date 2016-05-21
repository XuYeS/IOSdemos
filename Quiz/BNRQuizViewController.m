//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by 徐烨晟 on 16-3-25.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()
@property(nonatomic)int currentQuestionIndex;
@property(nonatomic,copy)NSArray *questions;
@property(nonatomic,copy)NSArray *answers;
@property(nonatomic,weak)IBOutlet UILabel *questionLabel;
@property(nonatomic,weak)IBOutlet UILabel *answerLabel;
@end

@implementation BNRQuizViewController
-(IBAction)showQuestion:(id)sender
{
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex==[self.questions count]) {
        
        self.currentQuestionIndex=0;
    }
    NSString *question=self.questions[self.currentQuestionIndex];
    
    self.questionLabel.text=question;
    
    self.answerLabel.text=@"???";

}

-(IBAction)showAnswer:(id)sender
{
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text= answer;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 
    if (self) {
    
        self.questions=@[@"From what is cognac made",
                         @"what is 7+7",
                         @"what is the capital of Vermont"
                         ];
        self.answers=@[@"Grapes",
                       @"14",
                       @"Montpelier"
                       ];
    }
    return self;
}
@end
