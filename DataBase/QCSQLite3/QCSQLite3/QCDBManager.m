//
//  QCDBManager.m
//  QCSQLite3
//
//  Created by 程庆春 on 2016/10/25.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import "QCDBManager.h"
#import <sqlite3.h>

static QCDBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation QCDBManager

+ (QCDBManager *)sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (BOOL)createDB {
    NSString *docDir;
    NSArray *dirPaths;

    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = dirPaths[0];
    dataBasePath = [[NSString alloc]initWithString:[docDir stringByAppendingPathComponent:@"student.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:dataBasePath] == NO) {
        const char *dbpath = [dataBasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "create table if not exists studentsDetail (regno integer primary key, name text, department text, year text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"failed to create table");
            }
            sqlite3_close(database);
            return isSuccess;
        }
    } else {
        isSuccess = NO;
        NSLog(@"failed to open/create database");
    }
    return isSuccess;
}
-(BOOL)saveData:(NSString *)registerNumber name:(NSString *)name department:(NSString *)department year:(NSString *)year {
    const char *dbpath = [dataBasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (regno,name, department, year) values (\"%ld\", \"%@\",\"%@\",\"%@\")", [registerNumber integerValue], name,department, year];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_OK) {
            return YES;
        } else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}
- (NSArray *)findByRegisterNumber:(NSString *)registerNumber {
    const char *dbpath = [dataBasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"select name, department, year from studentsDetail where regno=\"%@\"", registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_OK) {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_value(statement, 0)];
                [resultArray addObject:name];
                NSString *department = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_value(statement, 1)];
                [resultArray addObject:department];
                NSString *year = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_value(statement, 2)];
                [resultArray addObject:year];
                return resultArray;
            } else {
                NSLog(@"not found");
                return nil;
            }
            sqlite3_reset(statement);
        }
    }
    return nil;
}


@end
