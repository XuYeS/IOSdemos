//
//  XYSImageStore.h
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-11.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSImageStore : NSObject
+(instancetype)shareStore;
-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString *)key;
@end
