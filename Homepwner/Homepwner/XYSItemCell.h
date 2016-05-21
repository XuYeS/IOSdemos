//
//  XYSItemCell.h
//  Homepwner
//
//  Created by 徐烨晟 on 16-5-7.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *valueLable;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLable;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@property (nonatomic,copy)void (^actionBlock)(void);
@end
