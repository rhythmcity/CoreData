//
//  CoreDataHelper.h
//  CoreData
//
//  Created by 李言 on 15/9/3.
//  Copyright (c) 2015年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataHelper : NSObject
@property (nonatomic, readonly)NSManagedObjectContext       *context;
@property (nonatomic, readonly)NSManagedObjectModel         *model;
@property (nonatomic, readonly)NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly)NSPersistentStore            *store;
/**
 *  初始化CoreData
 */
-(void)setupCoreData;
/**
 *  保存上下文
 */
-(void)saveContext;
@end
