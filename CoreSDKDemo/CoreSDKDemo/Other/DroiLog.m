//
//  DroiLog.m
//  CoreSDKDemo
//
//  Created by Jon on 16/7/21.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiLog.h"

@implementation DroiLog

+ (void)droiLog:(NSString *)log{
    
    NSLog(@"%@",log);
    LJLog(@"%@",log);
}

@end
