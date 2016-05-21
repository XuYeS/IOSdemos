//
//  ViewController.m
//  ConcentricCircles
//
//  Created by 徐烨晟 on 16-4-8.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "ViewController.h"
#import "ConcentricCirclesView.h"
@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation ViewController
- (IBAction)remindButton:(UIButton *)sender {
    NSDate *date=self.datePicker.date;
    UILocalNotification *note=[[UILocalNotification alloc]init];
    note.alertBody=@"weak up!";
    note.fireDate=date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi=self.tabBarItem;
        tbi.title=@"Reminder";
        
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
