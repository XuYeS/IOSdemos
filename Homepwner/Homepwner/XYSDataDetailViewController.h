//
//  XYSDataDetailViewController.h
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-11.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSItem;
@interface XYSDataDetailViewController : UIViewController
@property (nonatomic,strong)XYSItem *item;
@property (nonatomic,copy)void (^dismissBlock)(void);

-(instancetype)initForNewItem:(BOOL)isNew;
@end
