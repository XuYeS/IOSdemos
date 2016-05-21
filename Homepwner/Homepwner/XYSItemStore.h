//
//  XYSItemStore.h
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-10.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYSItem;
@interface XYSItemStore : NSObject
@property (nonatomic,strong)NSArray *allItems;

+(instancetype)sharedStore;
-(XYSItem *)createItem;
-(void)removeItem:(XYSItem*)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(BOOL)saveChanges;
@end
