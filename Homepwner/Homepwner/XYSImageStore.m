//
//  XYSImageStore.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-11.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSImageStore.h"
@interface XYSImageStore()
@property (nonatomic,strong)NSMutableDictionary * imageDictionary;
-(NSString*)imagePathForKey:(NSString*)key;
@end

@implementation XYSImageStore
+(instancetype)shareStore
{
    static XYSImageStore * shareStore=nil;
//    if (!shareStore) {
//        shareStore = [[XYSImageStore alloc]initPrivate];
    static dispatch_once_t oneToken;//one thread safe;
    dispatch_once(&oneToken, ^{
        shareStore=[[XYSImageStore alloc]initPrivate];
    });
//    }
    return shareStore;
}
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use+[XYSImageStore shareStore]" userInfo:nil];
    return nil;
    
}

-(instancetype)initPrivate
{
    self=[super init];
    if (self) {
        _imageDictionary=[[NSMutableDictionary alloc]init];
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];//if you want other(not viewcontroller)objects can release cache when memorywarning,you should use notification center!
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    
    return self;
}
#pragma mark -memoryWarning
-(void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %d images out of cache",[self.imageDictionary count]);
    [self.imageDictionary removeAllObjects];
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.imageDictionary setObject:image forKey:key];
    NSString *imagePath = [self imagePathForKey:key];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:imagePath atomically:YES];
}
-(void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.imageDictionary removeObjectForKey:key];
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager]removeItemAtPath:imagePath error:nil];
}
-(UIImage *)imageForKey:(NSString *)key
{
    //return [self.imageDictionary objectForKey:key];
    UIImage *result = self.imageDictionary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        result = [UIImage imageWithContentsOfFile:imagePath];
    }
    if (result) {
        self.imageDictionary[key]=result;
    }
    else
    {
        NSLog(@"error:unable to find %@ ",[self imagePathForKey:key]);
    }
    return result;
}
#pragma mark -coding
-(NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}
@end
