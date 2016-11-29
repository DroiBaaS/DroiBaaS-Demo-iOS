//
//  DroiFeedbackDB.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/30.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedbackDB.h"
@implementation DroiFeedbackDB

static sqlite3 *db = nil;
//打开数据库(连接数据库)
+ (sqlite3 *)openDB
{
    if(db){
        return db;
    }
    //先判断沙盒了没有数据库,如果有直接打开,没有就把应用程序包里面的数据库拷贝一份到沙盒中
    //获取Documents路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //获取DroiFeedback.sqlite路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"DroiFeedback.sqlite"];
    //判断Documents是否存在DroiFeedback.sqlite文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"数据库路径：%@",filePath);
    //和数据库建立连接
    sqlite3_open([filePath UTF8String], &db);
    return db;
}
//关闭数据库(断开数据库连接)
+ (void)closeDB
{
    NSLog(@"数据库操作closeDB!");
    sqlite3_close(db);
    db = nil;
}


+ (void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
    }
}

+ (void)initializeDB{
    
    [self openDB];
    [self execSql:@"CREATE TABLE IF NOT EXISTS DroiFeedback (ID INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, createTime TEXT, reply TEXT, replyTime TEXT)"];
}

+ (NSArray *)allFeedback{
    
    sqlite3 *db = [self openDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "SELECT * FROM DroiFeedback", -1, &stmt, nil);
    NSMutableArray *array = nil;
    
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *content  = sqlite3_column_text(stmt, 1);
            const unsigned char *createTime = sqlite3_column_text(stmt, 2);
            const unsigned char *reply = sqlite3_column_text(stmt, 3);
            const unsigned char *replyTime = sqlite3_column_text(stmt, 4);

            DroiFeedbackModel *model = [[DroiFeedbackModel alloc] init];
            model.content = [NSString stringWithUTF8String:(const char *)content];
            model.createTime = [NSString stringWithUTF8String:(const char *)createTime];
            
            if ((const char *)reply) {
                model.reply = [NSString stringWithUTF8String:(const char *)reply];
            }
            if ((const char *)replyTime) {
                model.replyTime = [NSString stringWithUTF8String:(const char *)replyTime];
            }
            [array addObject:model];
        }
    }
    //8.释放stmt所占用的资源
    sqlite3_finalize(stmt);
    //9.将数组返回给外界
    return array;
}


+ (void)addFeedback:(DroiFeedbackModel *)model{
    
    //1.打开数据库
    sqlite3 *db = [self openDB];
    //2.创建语句对象
    sqlite3_stmt *stmt = nil;
    //3.准备语句对象
    int result = sqlite3_prepare_v2(db, "INSERT INTO DroiFeedback (content,createTime,reply,replyTime) values (?,?,?,?)", -1, &stmt, nil);
    if (result == SQLITE_OK) {

        sqlite3_bind_text(stmt, 1, [model.content UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [model.createTime UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [model.reply UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [model.replyTime UTF8String], -1, nil);

        //5.单步执行语句
        if(sqlite3_step(stmt) == SQLITE_DONE)
        {
            NSLog(@"插进去了");
        }
        else
        {
            NSLog(@"没插进去");
        }
    }
    //6.释放stmt所占用的资源
    sqlite3_finalize(stmt);

}

+ (void)deleteAllFeedback
{
    //1.打开数据库
    sqlite3 *db = [self openDB];
    //2.创建语句对象
    sqlite3_stmt *stmt = nil;
    //3.准备语句对象
    int result = sqlite3_prepare_v2(db, "DELETE FROM DroiFeedback", -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        
        if(sqlite3_step(stmt) == SQLITE_DONE)
        {
            NSLog(@"删除成功");
        }
        else
        {
            NSLog(@"删除失败");
        }
    }
    //6.释放stmt占用资源
    sqlite3_finalize(stmt);
}
@end
