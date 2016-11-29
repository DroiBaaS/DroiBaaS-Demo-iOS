//
//  DroiFeedbackConfig.h
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/30.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DroiFeedbackConfig : NSObject

@property (nonatomic , strong) UIColor *color;
@property (nonatomic , copy) NSString *userId;

+ (instancetype)defaultConfig;

@end
