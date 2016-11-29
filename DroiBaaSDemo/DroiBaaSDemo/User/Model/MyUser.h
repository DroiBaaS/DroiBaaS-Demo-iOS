//
//  MyUser.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/4.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <DroiCoreSDK/DroiCoreSDK.h>

@interface MyUser : DroiUser

DroiReference
@property(strong, nonatomic) DroiFile* icon;
DroiExpose
@property(copy, nonatomic) NSString* address;

DroiExpose
@property(copy, nonatomic) NSString *nickName;



@end
