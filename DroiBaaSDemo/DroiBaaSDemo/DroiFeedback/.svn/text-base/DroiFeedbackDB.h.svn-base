//
//  DroiFeedbackDB.h
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/30.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DroiFeedbackModel.h"

@interface DroiFeedbackDB : NSObject

//打开数据库
+ (sqlite3 *)openDB;
//关闭数据库
+ (void)closeDB;


+ (void)execSql:(NSString *)sql;

+ (void)initializeDB;

+ (NSArray *)allFeedback;

+ (void)addFeedback:(DroiFeedbackModel *)model;

+ (void)deleteAllFeedback;

@end
