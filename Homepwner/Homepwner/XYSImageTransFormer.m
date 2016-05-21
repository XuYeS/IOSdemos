//
//  XYSImageTransFormer.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-5-16.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSImageTransFormer.h"

@implementation XYSImageTransFormer
+(Class)transformedValueClass
{
    return [NSData class];
}
-(id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}
-(id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}
@end
