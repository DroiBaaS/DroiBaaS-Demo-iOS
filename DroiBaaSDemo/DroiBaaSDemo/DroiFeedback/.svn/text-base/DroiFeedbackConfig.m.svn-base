//
//  DroiFeedbackConfig.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/30.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedbackConfig.h"
#import <DroiCoreSDK/DroiCoreSDK.h>
@implementation DroiFeedbackConfig

static DroiFeedbackConfig *config = nil;

+ (instancetype)defaultConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[DroiFeedbackConfig alloc] init];
    });
    return config;
}


- (instancetype)init{
    
    if (self = [super init]) {
      
        self.color = [UIColor colorWithRed:50.0 / 256.0 green:147.0 / 256.0 blue:255.0 / 256.0 alpha:1];
        self.userId = [[DroiUser getCurrentUser] UserId];
    }
    return self;
}

- (NSString *)userId{
    
    if (_userId == nil) {
        _userId = [DroiUser getCurrentUser].UserId;
    }
    return _userId;
}


@end
