//
//  FMDBManager.m
//  ALL-Home
//
//  Created by 仁联sdiwen on 2020/6/28.
//  Copyright © 2020 renlian. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDatabase.h>
//将sql语句宏定义
#define CREAT_TABLE_IFNOT_EXISTS @"create table if not exists %@ ('name' TEXT NOT NULL,'create_time' TEXT NOT NULL)"

#define INSERT_INTO_TABLE   @"insert into %@ (create_time,name) values(?,?)"

#define   DELETE_TABLE     @"delete from %@ where name = ?"

#define  DELETE_ALL_TABLE  @"delete from %@"

#define   SELETE_TABLE     @"select * from %@ where 1=1 order by create_time desc limit 5"

@interface FMDBManager()

@property(nonatomic , strong)FMDatabase *dataBase;

@end

@implementation FMDBManager

+ (FMDBManager *)shareInstance{
    static FMDBManager *fmdbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdbManager = [[FMDBManager alloc]init];
    });
    return fmdbManager;
}

- (NSString *)getDBPath{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"dbpath = %@",dbPath);
    return dbPath;
}

//插入数据到收据库
- (BOOL)addNewDataWithTableName:(NSString *)tableName data:(NSArray *)newData{
    BOOL ret = false;
    NSString *dbPath = [self getDBPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    [self.dataBase open];
    if (![self.dataBase open]) {
        NSLog(@"dataBase open fail");
    }
    if ([self.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:CREAT_TABLE_IFNOT_EXISTS,tableName];
        ret = [self.dataBase executeUpdate:sql];
        if (ret) {
            NSLog(@"create table success");
            NSString *sql_Insert = [NSString stringWithFormat:INSERT_INTO_TABLE,tableName];
            BOOL result = [self.dataBase executeUpdate:sql_Insert withArgumentsInArray:newData];
            if (result) {
                NSLog(@"insert table SUCCESS");
            }else{
                NSLog(@"insert table fail");
            }
        }
    }
    return ret;
}

//读取数据库的内容
- (NSMutableArray *)readDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey {
    NSString *dbPath = [self getDBPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    [self.dataBase open];
    NSString *sql = [NSString stringWithFormat:SELETE_TABLE,tableName];
    FMResultSet *resultSet = [self.dataBase executeQuery:sql];
    NSMutableArray *contentArray = [NSMutableArray array];
    while ([resultSet next]) {
        NSString *content = [resultSet stringForColumn:@"name"];
        NSString *createTime = [resultSet stringForColumn:@"create_time"];
        NSLog(@"从数据库查询到的历史记录-- %@,创建时间%@",content,createTime);
        [contentArray addObject:content];
    }
    return contentArray;
}

- (BOOL)deleteDataWithTableName:(NSString *)tableName data:(NSArray *)data{
    BOOL ret = false;
    NSString *dbPath = [self getDBPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    if ([self.dataBase open]) {
        NSString *deleteSql = [NSString stringWithFormat:DELETE_TABLE,tableName];
        ret = [self.dataBase executeUpdate:deleteSql withArgumentsInArray:data];
        if (ret) {
            NSLog(@"delete table success");
        }else{
            NSLog(@"delete table fail");
        }
    }
    return ret;
}

- (BOOL)deleteALLDataWithTableName:(NSString *)tableName{
    BOOL ret = false;
    NSString *dbPath = [self getDBPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    if ([self.dataBase open]) {
        NSString *deleteSql = [NSString stringWithFormat:DELETE_ALL_TABLE,tableName];
        ret = [self.dataBase executeUpdate:deleteSql];
        if (ret) {
            NSLog(@"delete table alldata success");
        }else{
            NSLog(@"delete table alldata  fail");
        }
    }
    return ret;
}



@end
