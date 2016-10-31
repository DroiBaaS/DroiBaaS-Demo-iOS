//
//  DroiLog.h
//  CoreSDKDemo
//
//  Created by Jon on 16/7/21.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LJLogView.h>
#define DroiLog(...)  [DroiLog droiLog:[NSString stringWithFormat:__VA_ARGS__]]


@interface DroiLog : NSObject

+ (void)droiLog:(NSString *)log;

@end
