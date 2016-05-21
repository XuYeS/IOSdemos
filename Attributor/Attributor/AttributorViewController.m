//
//  AttributorViewController.m
//  Attributor
//
//  Created by 徐烨晟 on 16-4-2.
//  Copyright (c) 2016年 ___FULLUSERNAME___. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textBody;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIButton *outletButton;

@end

@implementation AttributorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title=
    [[NSMutableAttributedString alloc] initWithString:self.outletButton.currentTitle];
    [title setAttributes:@{ NSStrokeWidthAttributeName: @3,
                            NSStrokeColorAttributeName:self.outletButton.tintColor
                            }
                   range:NSMakeRange(0, title.length)];
    [self.outletButton setAttributedTitle:title forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(preferredFontsChanged:)
                                                name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

-(void)preferredFontsChanged:(NSNotification *)notification
{
    [self usePreferredFonts];
}

-(void)usePreferredFonts
{
    self.textBody.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.outletButton.titleLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}



- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
    
    [self.textBody.textStorage addAttribute:NSForegroundColorAttributeName
                                      value:sender.backgroundColor
                                      range:self.textBody.selectedRange];
}

- (IBAction)setupOutline:(UIButton *)sender
{
    [self.textBody.textStorage addAttributes:@{ NSStrokeWidthAttributeName: @-3,
                                                NSStrokeColorAttributeName:[UIColor orangeColor]
                                                }
                                       range:self.textBody.selectedRange];
}
- (IBAction)unsetupOutline:(UIButton *)sender
{
    [self.textBody.textStorage removeAttribute:NSStrokeWidthAttributeName
                                         range:self.textBody.selectedRange];
}








@end
