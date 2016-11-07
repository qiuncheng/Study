//
//  FMDBManager.h
//  FMDBDemo
//
//  Created by 程庆春 on 07/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
/// 在这里传入model就可以

@interface FMDBManager : NSObject

- (void) updateDataWithName:(NSString *)name age:(NSString*) age date:(float)date;
- (void) insertDataWithName:(NSString *)name age:(NSString*)age date:(NSString *)date;
- (void) queryDataWithName:(NSString *)name;
- (void) deleteDataWithName:(NSString *)name age:(NSString *)age;
- (void) createTable;

@end

