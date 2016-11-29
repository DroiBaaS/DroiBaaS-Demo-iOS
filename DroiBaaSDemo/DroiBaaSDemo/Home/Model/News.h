//
//  News.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/9.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <DroiCoreSDK/DroiCoreSDK.h>
@interface News : DroiObject

DroiExpose
@property(copy, nonatomic) NSString* newsDescription;
DroiExpose
@property(strong, nonatomic) NSString* smallImage;
DroiExpose
@property(copy, nonatomic) NSString* htmlString;
DroiExpose
@property(copy, nonatomic) NSString* authorName;
DroiExpose
@property(assign, nonatomic) NSInteger tag;
DroiExpose
@property(assign, nonatomic) NSInteger type;
DroiExpose
@property(copy, nonatomic) NSString *contentId;

@end
