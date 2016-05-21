//
//  XYSItemStore.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-10.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSItemStore.h"
#import "XYSItem.h"
#import "XYSImageStore.h"
@interface XYSItemStore()
@property (strong,nonatomic)NSMutableArray * privateItems;
@property (strong,nonatomic)NSMutableArray *allAssetTypes;
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (strong,nonatomic)NSManagedObjectModel *model;

@end

@implementation XYSItemStore
+(instancetype)sharedStore
{
    static XYSItemStore *shareStore=nil;
//    if (!shareStore) {
//        shareStore=[[XYSItemStore alloc]initPrivate];
//    }
    static dispatch_once_t oneToken;//GCD
    dispatch_once(&oneToken, ^{
        shareStore=[[XYSItemStore alloc]initPrivate];
    });
    return shareStore;
}
//if use[XYSItemStore init] will tell use [XYSItemStore shareStore]
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use+[XYSItemStore shareStore]" userInfo:nil];
    return nil;
    
}
-(instancetype)initPrivate
{
    self=[super init];
    if (self) {
        _privateItems=[[NSMutableArray alloc]init];
        NSString *path=[self itemArchivePath];
        _privateItems=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_privateItems) {
            _privateItems=[[NSMutableArray alloc]init];
        }

        
    }
    return self;
}

//other file can't change allItems,but in private it can change it by using NSMutableArray *privateItems
-(NSArray *)allItems
{
    return self.privateItems;//copy return a inmutable copy  ,if mutable use mutableCopy
}

-(XYSItem *)createItem
{
    //XYSItem *item=[XYSItem randomItem];
    XYSItem *item=[[XYSItem alloc]initWithItemName:@"" valueInDollars:0 serialNumber:@""];
    [self.privateItems addObject:item];
    return item;
}
-(void)removeItem:(XYSItem *)item
{
    //[self.privateItems removeObject:item];
    NSString *key=item.itemKey;
    [[XYSImageStore shareStore]deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];//better use?
    
}
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex==toIndex) {
        return;
    }
    else
    {
        XYSItem *item=[self.privateItems objectAtIndex:fromIndex];
        [self.privateItems removeObjectAtIndex:fromIndex];
        [self.privateItems insertObject:item atIndex:toIndex];
    }
    
}
#pragma mark -coding
-(NSString*)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory= [documentDirectories firstObject];
    
    //return [documentDirectory stringByAppendingPathComponent:@"item.archive"];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

-(BOOL)saveChanges
{
    NSString *path=[self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}





@end
