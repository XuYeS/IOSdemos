//
//  XYSItemCell.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-5-7.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSItemCell.h"

@implementation XYSItemCell
- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
