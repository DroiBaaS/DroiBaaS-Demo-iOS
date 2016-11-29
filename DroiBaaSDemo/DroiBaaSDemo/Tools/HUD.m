//
//  HUD.m
//  ruhang
//
//  Created by Jon on 2016/11/29.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HUD.h"

@interface HUD ()

@end
@implementation HUD

static HUD *_instance = nil;


+ (void)show{
    
    if (_instance == nil) {
        _instance = [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
}
+ (void)dismiss{
    
    if (_instance) {
        [_instance hideAnimated:YES afterDelay:2];
        _instance = nil;
    }
}

+ (void)showText:(NSString *)text{
    
    if (_instance == nil) {
        _instance = [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    _instance.mode = MBProgressHUDModeText;
    _instance.label.text = text;
}


@end
