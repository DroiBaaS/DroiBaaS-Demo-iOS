//
//  AppDelegate.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/6/8.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "AppDelegate.h"
#import <DroiCoreSDK/DroiCoreSDK.h>
#import <DroiPush/DroiPush.h>
#import <DroiAnalytics/DroiAnalytics.h>
#import "DroiLog.h"
#import "News.h"
#import "MyUser.h"
#import "CommentModel.h"
#import "NewsRelation.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [DroiCore initializeCore];
    
    [DroiObject registerCustomClass:[MyUser class]];
    [DroiObject registerCustomClass:[CommentModel class]];
    [DroiObject registerCustomClass:[News class]];
    [DroiObject registerCustomClass:[NewsRelation class]];

    //启用DroiPush
    [DroiPush registerForRemoteNotifications];
    //启用DroiAnalytics
//    [DroiAnalytics startAnalytics];
    
    [self setDefaultPermission];
    return YES;
}


//配置DroiObject默认权限  如果不配置的话 默认权限为仅当前用户可读可写
- (void)setDefaultPermission{

    DroiPermission* permission = [DroiPermission getDefaultPermission];
    if (permission == nil)
        permission = [DroiPermission new];
    // 设置预设权限为所有用户可读
    [permission setPublicReadPermission:YES];
    [DroiPermission setDefaultPermission:permission];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [DroiPush registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"获取到通知:%@",userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [DroiPush setBadge:0];
}


@end
