//
//  ScrollViewController.m
//  ConcentricCircles
//
//  Created by 徐烨晟 on 16-4-9.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "ScrollViewController.h"
#import "ConcentricCirclesView.h"
@interface ScrollViewController () <UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic)ConcentricCirclesView *concentricCirclesView;
@property (strong,nonatomic)ConcentricCirclesView *rightConcentricCirclesView;
@end

@implementation ScrollViewController
@synthesize concentricCirclesView=_concentricCirclesView;

-(ConcentricCirclesView *)concentricCirclesView
{
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if (!_concentricCirclesView) {
        _concentricCirclesView=[[ConcentricCirclesView alloc]initWithFrame:frame];
    }
    return _concentricCirclesView;
}
-(ConcentricCirclesView *)rightConcentricCirclesView
{
    CGRect frame=CGRectMake(0+self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    if (!_rightConcentricCirclesView) {
        _rightConcentricCirclesView=[[ConcentricCirclesView alloc]initWithFrame:frame];
    }
    return _rightConcentricCirclesView;
}
-(void)drawRadomSleepyLables:(NSString *)message
{
    for (int i=0; i<20; i++)
    {
        UILabel *sleepyLable=[[UILabel alloc]init];
        sleepyLable.backgroundColor=[UIColor clearColor];
        sleepyLable.textColor=[UIColor blackColor];
        sleepyLable.text=message;
        [sleepyLable sizeToFit];
        
        int x = arc4random()%(int)(self.view.bounds.size.width-sleepyLable.bounds.size.width);
        int y = arc4random()%(int)(self.view.bounds.size.height-sleepyLable.bounds.size.width);
        
        
        
       // CGRect frame=sleepyLable.frame;
        //frame.origin=CGPointMake(x, y);
        CGRect frame= CGRectMake(x, y, sleepyLable.frame.size.width, sleepyLable.frame.size.height);
        sleepyLable.frame=frame;
        

        
        [self.view addSubview:sleepyLable];
    }
    
}

-(void)loadView
{
    self.tabBarItem.title=@"sleepy";
    CGRect frame=[UIScreen mainScreen].bounds;
    ConcentricCirclesView *backgroundView=[[ConcentricCirclesView alloc]initWithFrame:frame];
    
    CGRect textFieldRect=CGRectMake(40, 70, 230, 30);
    UITextField *textField=[[UITextField alloc]initWithFrame:textFieldRect];
    
    textField.borderStyle=UITextBorderStyleRoundedRect;
    textField.placeholder=@"sleepy~~";
    textField.returnKeyType=UIReturnKeyDone;
    
    textField.delegate=self;
    [backgroundView addSubview:textField];
    
    self.view=backgroundView;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    [self drawRadomSleepyLables:textField.text];
    
    textField.text=@" ";
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //UIImage *i=[UIImage imageNamed:@"heart1"];
    
    //self.tabBarItem.image=i;
   // self.scrollView.contentSize=CGSizeMake(self.concentricCirclesView.bounds.size.width*2.0, self.concentricCirclesView.bounds.size.height) ;
    
    
    //[self.view addSubview:self.concentricCirclesView];
    //[self.scrollView addSubview:self.rightConcentricCirclesView];
    
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
