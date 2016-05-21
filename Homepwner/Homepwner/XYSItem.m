//
//  XYSItem.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-10.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSItem.h"

@implementation XYSItem
-(instancetype)initWithItemName:(NSString*)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self=[super init];
    if (self) {
        _itemName=name;
        _valueInDollars=value;
        _serialNumber=sNumber;
        
        _dateCreate=[[NSDate alloc]init];
        NSUUID *uuid=[[NSUUID alloc]init];
        NSString *key=[uuid UUIDString];
        _itemKey=key;
    }
    return self;
}

+(instancetype)randomItem
{
    NSArray *randomAdjectiveList=@[@"",@"",@""];
    NSArray *randomNounList=@[@"",@"",@""];
    NSInteger adjectiveIndex = arc4random()%[randomAdjectiveList count];
    NSInteger nounIndex=arc4random()%[randomNounList count];
    
    NSString *randomName=[NSString stringWithFormat:@"%@%@",
                          [randomAdjectiveList objectAtIndex:adjectiveIndex],
                          [randomNounList objectAtIndex:nounIndex]];
    int randomValue =0;
    NSString *randomSerialNumber=@" ";
    XYSItem *newItem=[[self alloc]initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) :Worth:$ %d,%@",self.itemName,self.serialNumber,self.valueInDollars,self.dateCreate];
}
-(void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize=image.size;
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    float ratio = MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width=ratio* origImageSize.width;
    projectRect.size.height=ratio*origImageSize.height;
    projectRect.origin.x=(newRect.size.width-projectRect.size.width)/2.0;
    projectRect.origin.y=(newRect.size.height-projectRect.size.height)/2.0;
    
    [image drawInRect:projectRect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail=smallImage;
    
    UIGraphicsEndImageContext();
    
}
#pragma mark -coder
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        _itemName=[aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber=[aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreate=[aDecoder decodeObjectForKey:@"dateCreate"];
        _itemKey=[aDecoder decodeObjectForKey:@"itemKey"];
        _valueInDollars=[aDecoder decodeIntForKey:@"valueInDollars"];
        _thumbnail=[aDecoder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollar"];
    [aCoder encodeObject:self.dateCreate forKey:@"dateCreate"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
}
@end
