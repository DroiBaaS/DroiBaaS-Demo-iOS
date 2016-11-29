//
//  CommentModel.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/8.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <DroiCoreSDK/DroiCoreSDK.h>
#import "MyUser.h"
#import "News.h"
@interface CommentModel : DroiObject

DroiReference
@property(strong, nonatomic) MyUser* author; //author

DroiExpose
@property(copy, nonatomic) NSString* userId; //newsId;

DroiExpose
@property(copy, nonatomic) NSString* newsId; //newsId;

DroiExpose
@property(copy, nonatomic) NSString* comment;
@end
