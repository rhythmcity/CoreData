//
//  CoreDataHelper.m
//  CoreData
//
//  Created by 李言 on 15/9/3.
//  Copyright (c) 2015年 李言. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper
//#define debug 1 

NSString *storeFilename = @"CoreDataTest.sqlite";

#pragma mark   -PATHS
-(NSString *)applicationDocunmentsDirectory{
    
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
        
    }
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL *)applicationStoreDirectory{
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocunmentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory  withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (DEBUG == 1) {
                NSLog(@"Successfully created stores directory");
            }
        }else{
            NSLog(@"FAILED to create Stores directory : %@",error);
        }
    }
    return storesDirectory;
}

-(NSURL *)storeURL{
    
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    return [[self applicationStoreDirectory] URLByAppendingPathComponent:storeFilename];
}

#pragma mark - SETUP

-(instancetype)init{

    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    
    self = [super init];
    if (!self) {return nil;}
    
    _model       = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    
    _context     = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [_context setPersistentStoreCoordinator:_coordinator];
    
    return self;
}

-(void)loadStore{
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    
    if (_store) {return;}
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeURL]
                                              options:nil
                                                error:&error];
    if (!_store) {
        NSLog(@"FAILED to add store . Error %@",error);
        abort();
    }else{
        if (DEBUG == 1) {
            NSLog(@"Succeesfully added store %@",_store);
        }
    }

}

-(void)setupCoreData{
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    [self loadStore];
}

#pragma mark - SAVING

-(void)saveContext{
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persitent store");
        }else{
            NSLog(@"FAILED to save _context %@",error);
        }
    }else{
    
        NSLog(@"SKIPPED _context save, there are no changes");
    }
}

@end
