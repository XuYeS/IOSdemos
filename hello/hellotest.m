//
//  hellotest.m
//  hello
//
//  Created by 徐烨晟 on 16-3-20.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "hellotest.h"

@implementation hellotest
@synthesize string;
-(void)initVal
{
    aaa = 100;
}

-(void)printVal
{
    NSLog(@"%i",aaa);
}

-(void)printVal:(int)a printVal2:(int)b printVal3:(int)c
{
    NSLog(@"%i,",aaa+a+b+c);
}

-(void)printf
{
    NSLog(@"this is print by protocol! \n");
}

-(void)printfnot:(int)n
{
    NSLog(@"this is print by protocol! :%i\n",n);
}

-(void)go
{
    NSLog(@"gogogo\n");
}

@end
