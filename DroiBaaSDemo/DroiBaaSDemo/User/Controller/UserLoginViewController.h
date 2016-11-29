//
//  UserLoginViewController.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


typedef NS_ENUM(NSUInteger, UserLoginViewControllerStyle) {
    LoginStyle      = 1,
    RegisterStyle
};
@interface UserLoginViewController : BaseViewController

- (instancetype)initWithStyle:(UserLoginViewControllerStyle )style;

@end
