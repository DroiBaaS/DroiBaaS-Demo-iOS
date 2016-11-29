//
//  DroiFeedbackRequest.h
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/28.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DroiFeedbackRequestCallback)(BOOL sucess,id object);
@interface DroiFeedbackRequest : NSObject

+ (void)requestToGetFeedback:(DroiFeedbackRequestCallback)callback;

+ (void)requestToSummitFeedback:(NSString *)feedbackString contact:(NSString *)contact callback:(DroiFeedbackRequestCallback)callback;
@end
