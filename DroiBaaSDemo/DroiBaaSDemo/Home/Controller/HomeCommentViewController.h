//
//  HomeCommentViewController.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "BaseViewController.h"
#import "MyUser.h"
@interface HomeCommentViewController : BaseViewController

- (instancetype)initWithNews:(News *)news;

- (instancetype)initWithUser:(MyUser *)user;


@end
