//
//  AppDelegate.h
//  CoreData
//
//  Created by 李言 on 15/9/3.
//  Copyright (c) 2015年 李言. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic,readonly)CoreDataHelper *coreDataHelper;


@end

