//
//  FMDBManager.m
//  FMDBDemo
//
//  Created by 程庆春 on 07/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDB/FMDB.h>

@implementation FMDBManager

static FMDatabase *database = nil;

- (void) createTable {
    FMDatabase *db = [self currentDatabase];
    if ([db goodConnection]) {
        [db open];
    }
    BOOL createTableResult = [db executeUpdate:@"create table if not exists student(id integer primary key autoincrement, name text, age text, date text)"];
    if (createTableResult) {
        NSLog(@"创建表成功！");
    } else {
        NSLog(@"创建表失败！");
    }
    [db close];
}
- (void) insertDataWithName:(NSString *)name age:(NSString*)age date:(NSString *)date {
    FMDatabase *db = [self currentDatabase];
    NSLog(@"%@", [db databasePath]);
    if ([db goodConnection]) {
        [db open];
    }
    BOOL insertDataResult = [db executeUpdate:@"INSERT INTO student(name, age, date) values(?, ?, ?)", name, age,date];
    [db close];
    if (insertDataResult) {
        NSLog(@"insert successfully.");
    } else {
        NSLog(@"insert failed");
    }
}

- (void) updateDataWithName:(NSString *)name age:(NSString*) age date:(float)date {
    FMDatabase *db = [self currentDatabase];
    if ([db goodConnection]) {
        [db open];
    }
    BOOL updateDataResult = [db executeUpdate:@"update student SET name = ? and age = ? where name = 'ggggg'", name, age];
    if (updateDataResult) {
        NSLog(@"update successfully.");
    } else {
        NSLog(@"update failed.");
    }
    [db close];
}
- (void) deleteDataWithName:(NSString *)name age:(NSString *)age{
    FMDatabase *db = [self currentDatabase];
    if ([db goodConnection]) {
        [db open];
    }
    BOOL deleteDataResult = [db executeUpdate:@"DELETE FROM student WHERE name = ? and age = ?", name, age];
    [db close];

    if (deleteDataResult) {
        NSLog(@"deleted successfully");
    }
    else {
        NSLog(@"delete failed");
    }
}
- (void )queryDataWithName:(NSString *)name {
    FMDatabase *db = [self currentDatabase];
    if ([db goodConnection]) {
        [db open];
    }
    FMResultSet *result = [db executeQuery:@"SELECT * FROM student where name = ?", name];
    [db close];

    if (result != nil) {
        NSLog(@"query successfully");
    }
    else {
        NSLog(@"query failed");
    }
    while ([result next]) {
        NSLog(@"%@ --- %@ --- %@", [result stringForColumn:@"name"], [result stringForColumn:@"age"], [result stringForColumn:@"date"]);
    }
//    return result;
}

#pragma mark -
- (FMDatabase *) currentDatabase {
    if (database == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [paths objectAtIndex:0];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"Student.sqlite"];
        database = [FMDatabase databaseWithPath:dbPath];
    }
    return database;
}

@end
