//
//  FMDBManager.h
//  ALL-Home
//
//  Created by 仁联sdiwen on 2020/6/28.
//  Copyright © 2020 renlian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

+ (FMDBManager *)shareInstance;

- (BOOL)addNewDataWithTableName:(NSString *)tableName data:(NSArray *)newData;

- (NSMutableArray *)readDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey;

- (BOOL)deleteDataWithTableName:(NSString *)tableName data:(NSArray *)data;

- (BOOL)deleteALLDataWithTableName:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
