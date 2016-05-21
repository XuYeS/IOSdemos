//
//  main.m
//  hello
//
//  Created by 徐烨晟 on 16-3-20.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>
#import "hellotest.h"
#import "hellotestson.h"
#import "hellotest+hellocategory.h"
int main(int argc, const char * argv[])
{
  
    NSString* filename=@"/Users/xuyesheng/Desktop/wendang.c";
    
    NSFileManager* hellofile;
    hellofile=[NSFileManager defaultManager];
    if([hellofile fileExistsAtPath:filename]==YES)
    {
        NSLog(@"file exist");
    }
    else
    {
        NSLog(@"file not exst");
    }
    [hellofile copyPath:filename toPath:@"/Users/xuyesheng/Desktop/wendang2.c" handler:(nil)];
    
    if([hellofile contentsEqualAtPath:filename andPath:@"/Users/xuyesheng/Desktop/wendang2.c"]==YES)
    {
         NSLog(@"file same");
    }
    else
    {
         NSLog(@"file not same");
    }
    
    if([hellotest conformsToProtocol:@protocol(Protocolhellotest2)]==1)
    {
        NSLog(@"be conform!\n");
    }
    else
    {
        NSLog(@"not conform!\n");
    }
    
    return 0;
}

