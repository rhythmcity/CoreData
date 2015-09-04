//
//  AppDelegate.m
//  CoreData
//
//  Created by 李言 on 15/9/3.
//  Copyright (c) 2015年 李言. All rights reserved.
//

#import "AppDelegate.h"
#import "Item.h"
#import "Measurement.h"
#import "Amount.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    return YES;
}


-(CoreDataHelper *)cdh{

    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    
    if (!_coreDataHelper) {
        _coreDataHelper = [CoreDataHelper defaultCoreDataHelper];
        
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}

-(void)demo{
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Amount"];
    [request setFetchLimit:50];
    NSError *error = nil;
    
    
//    NSSortDescriptor *sort  = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
//    NSPredicate *filter     = [NSPredicate predicateWithFormat:@"name != %@",@"Coffee"];
//    [request setPredicate:filter];
    NSArray *fetchObjects   = [[CoreDataHelper defaultCoreDataHelper].context executeFetchRequest:request error:nil];
    
    for (Amount * amount in fetchObjects) {
//        [[CoreDataHelper defaultCoreDataHelper].context deleteObject:item];
        NSLog(@"%@",amount.xyz);
    }
    

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[self cdh] saveContext];
 
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (DEBUG == 1) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd) );
    }

    [self cdh];
    [self demo];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[self cdh] saveContext];
  
}
@end
