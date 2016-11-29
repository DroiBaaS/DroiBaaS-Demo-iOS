//
//  DroiFeedbackRequest.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/28.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedbackRequest.h"
#import "DroiHttp.h"
#import <DroiCoreSDK/DroiCoreSDK.h>
#import "DroiFeedbackConfig.h"

#ifdef kTest
static NSString * const kAddFeedbackURL = @"http://10.0.10.213:8000/droifeedback/1/add";
static NSString * const kGetFeedbackURL = @"http://10.0.10.213:8000/droifeedback/1/list";
#else
static NSString * const kAddFeedbackURL = @"/droifeedback/1/add";
static NSString * const kGetFeedbackURL = @"/droifeedback/1/list";
#endif

@implementation DroiFeedbackRequest


+ (void)requestToSummitFeedback:(NSString *)feedbackString contact:(NSString *)contact callback:(DroiFeedbackRequestCallback)callback{
  
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:feedbackString forKey:@"content"];
    [parameter setObject:contact forKey:@"contact"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [self postRequsetWithURLString:kAddFeedbackURL parameter:parameter];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (data) {
                NSError *error = nil;
                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
                if (callback) {
                    if (error) {
                        callback(NO,nil);
                    }
                    else{
                        callback(YES,object);
                    }
                }
            }
            else{
                if (callback) {
                    callback(NO,nil);
                }
            }
        });
    });
    
}

+ (void)requestToGetFeedback:(DroiFeedbackRequestCallback)callback{
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [self postRequsetWithURLString:kGetFeedbackURL parameter:parameter];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (data) {
                NSError *error = nil;
                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
                NSLog(@"%@",object);
                if (!error) {
                    NSNumber *code = [object valueForKey:@"code"];
                    if (code.integerValue == 0) {
                        
                        //当没有反馈的时候，返回来的result是一个字符串，所以得判断下返回的类型
                        id feedbackArr = [object valueForKey:@"result"];
                        
                        if ([feedbackArr isKindOfClass:[NSString class]]) {
                            if (callback) {
                                callback(YES,@[]);
                            }
                        }
                        else{
                            if (callback) {
                                callback(YES,feedbackArr);
                                }
                        }
                    }
                }
                else{
                    if (callback) {
                        callback(NO,nil);
                    }
                }
            }
            else{
                callback(NO,nil);
            }
        });
    });
}


+ (NSData *)postRequsetWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter{
    
    if (![DroiFeedbackConfig defaultConfig].userId) {
        return nil;
    }
    NSString *appId = [DroiCore getDroiAppId];
    NSString *deviceId = [DroiCore getDroiDeviceId];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    [param setObject:appId forKey:@"appId"];
    
    [param setObject:[DroiFeedbackConfig defaultConfig].userId forKey:@"userId"];
    NSData *parameterData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];

    DroiHttp *http = [DroiHttp instance];
   DroiHttpRequest *request = [DroiHttpRequest requestWithService:URLString Data:parameterData];
    [request addValue:appId withHeaderName:@"X-Droi-AppID"];
    [request addValue:deviceId withHeaderName:@"X-Droi-DeviceID"];
    [request addValue:appId withHeaderName:@"X-Droi-Platform-Key"];

    DroiHttpResponse *respone = [http request:request];
    
    if (respone) {
        int errCode = respone.errorCode;
        int statusCode = respone.droiStatusCode;
        int httpCode = respone.httpStatusCode;
        NSLog(@"errCode:%d  statusCode:%d httpCode:%d",errCode,statusCode,httpCode);
        if (errCode == 0 && httpCode == 200) {
            return respone.data;
        }
    }
    return nil;
}
@end
