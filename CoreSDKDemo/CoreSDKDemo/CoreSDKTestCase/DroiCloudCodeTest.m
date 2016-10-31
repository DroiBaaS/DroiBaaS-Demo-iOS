//
//  DroiCloudCodeTest.m
//  CoreSDKDemo
//
//  Created by Jon on 16/8/22.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiCloudCodeTest.h"
#import <DroiCoreSDK/DroiCoreSDK.h>
#import "DroiLog.h"
@interface AddInput : DroiObject
DroiExpose
@property float num1;
DroiExpose
@property float num2;
@end
@implementation AddInput
@end
@interface AddResult : DroiObject
DroiExpose
@property float result;
@end
@implementation AddResult
@end


@implementation DroiCloudCodeTest


- (void)demoCallSimpleCloudCode {
    
    AddInput* addInput = [AddInput new];
    addInput.num1 = 1.0;
    addInput.num2 = 2.0;
    DroiError *error = nil;
    AddResult* result = [DroiCloud callCloudService:@"add.lua"
                                          parameter:addInput
                                       andClassType:[AddResult class]
                                              error:&error];
    if (error.isOk) {
        DroiLog(@"Result: %@", result);
      }
}


- (void)demoCallSimpleCloudCodeInBackground {
    AddInput* addInput = [AddInput new];
    addInput.num1 = 1.0;
    addInput.num2 = 2.0;
 
        [DroiCloud callCloudServiceInBackground:@"add.lua" parameter:addInput andCallback:^(id result, DroiError *error) {
            if (error.isOk) {
                DroiLog(@"Result: %@", result);
            }
        } withClassType:[AddResult class]];

}

- (void)demoCloudPreferences{
    
    DroiPreference *preference = [DroiPreference instance];
    [preference refresh];
    DroiLog(@"key1:%@",[preference valueForKey:@"key1"]);
    DroiLog(@"key2:%@",[preference valueForKey:@"key2"]);
    DroiLog(@"key3:%@",[preference valueForKey:@"key3"]);
    DroiLog(@"key4:%@",[preference valueForKey:@"key4"]);
    DroiLog(@"key5:%@",[preference valueForKey:@"key5"]);

}

@end
