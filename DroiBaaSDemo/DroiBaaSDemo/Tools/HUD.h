//
//  HUD.h
//  ruhang
//
//  Created by Jon on 2016/11/29.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface HUD : MBProgressHUD
+ (void)show;
+ (void)dismiss;

+ (void)showText:(NSString *)text;
@end
