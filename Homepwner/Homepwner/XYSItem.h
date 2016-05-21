//
//  XYSItem.h
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-10.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSItem : NSObject <NSCoding>
@property (nonatomic,strong)NSString *itemName;
@property (nonatomic,strong)NSString *serialNumber;
@property (nonatomic)int valueInDollars;
@property (nonatomic,strong,readonly)NSDate *dateCreate;
@property (nonatomic,copy)NSString *itemKey;
@property (nonatomic,strong)UIImage *thumbnail;
-(void)setThumbnailFromImage:(UIImage *)image;
+(instancetype)randomItem;
-(instancetype)initWithItemName:(NSString*)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
@end
