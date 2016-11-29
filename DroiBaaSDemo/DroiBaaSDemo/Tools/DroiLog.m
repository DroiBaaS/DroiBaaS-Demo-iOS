//
//  DroiLog.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/1.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiLog.h"

@implementation DroiLog


+ (void)alertLogWithViewController:(UIViewController *)viewController String:(NSString *)alertString completion:(void (^)(void))completion{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:alertString preferredStyle:UIAlertControllerStyleAlert];
    [viewController presentViewController:alert animated:YES completion:^{
        
        dispatch_after(0, dispatch_get_main_queue(), ^{
            sleep(1);
            [alert dismissViewControllerAnimated:YES completion:completion];
        });
        
    }];
}
@end
