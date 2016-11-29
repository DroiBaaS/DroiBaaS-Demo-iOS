//
//  DroiFeedback.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/27.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedback.h"
#import "DroiFeedbackViewController.h"
#import "DroiFeedbackConfig.h"
@implementation DroiFeedback

+ (void)callFeedbackWithViewController:(UIViewController *)viewController{
    
    DroiFeedbackViewController *feedbackVC = [[DroiFeedbackViewController alloc] init];
    UINavigationController *feedbackNav = [[UINavigationController alloc] initWithRootViewController:feedbackVC];
    [viewController presentViewController:feedbackNav animated:YES completion:nil];
    
}

+ (void)setUserId:(NSString *)userId{
    
    [DroiFeedbackConfig defaultConfig].userId = userId;
}

+ (void)setColor:(UIColor *)color{
    
    [DroiFeedbackConfig defaultConfig].color = color;
}

+ (NSString *)getCurrentUserId{
    
    return [DroiFeedbackConfig defaultConfig].userId;
}
@end
