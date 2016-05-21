//
//  XYSDrawViewController.m
//  TouchTracker
//
//  Created by 徐烨晟 on 16-4-12.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSDrawViewController.h"
#import "XYSDrawView.h"
@interface XYSDrawViewController ()

@end

@implementation XYSDrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    self.view=[[XYSDrawView alloc]initWithFrame:CGRectZero];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
