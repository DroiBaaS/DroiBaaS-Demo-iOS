//
//  NewsRelation.h
//  DroiBaaSDemo
//
//  Created by Jon on 2016/11/25.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <DroiCoreSDK/DroiCoreSDK.h>
#import "MyUser.h"
#import "News.h"
@interface NewsRelation : DroiObject
DroiReference
@property(strong, nonatomic) MyUser* colletUser;
DroiReference
@property(strong, nonatomic) News* news;
DroiExpose
@property(copy, nonatomic) NSString* colletUserId;
DroiExpose
@property(copy, nonatomic) NSString* newsId;
@end
