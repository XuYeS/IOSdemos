//
//  hellotest.h
//  hello
//
//  Created by 徐烨晟 on 16-3-20.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocolhellotest.h"
#import "Protocolhellotest2.h"
@interface hellotest : NSObject <Protocolhellotest,Protocolhellotest2>
{
@protected int aaa;
    NSString *string;
}
@property(retain) NSString* string;
-(void)initVal;
-(void)printVal;
-(void)printVal:(int)a printVal2:(int)b printVal3:(int)c;


@end
