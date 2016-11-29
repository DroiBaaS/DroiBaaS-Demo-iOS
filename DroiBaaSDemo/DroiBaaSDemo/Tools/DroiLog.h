//
//  DroiLog.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/1.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;"
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;"
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"

#define DroiLogError(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

#define DroiLogInfo(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg65,105,225;" frmt  XCODE_COLORS_RESET), ##__VA_ARGS__)

#define DroiLogWarn(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,128,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

#define DroiLogAlert(...)  [DroiLog alertLogWithViewController:self String:[NSString stringWithFormat:__VA_ARGS__] completion:nil];
@interface DroiLog : NSObject


+ (void)alertLogWithViewController:(UIViewController *)viewController String:(NSString *)alertString completion:(void (^)(void))completion;

@end
