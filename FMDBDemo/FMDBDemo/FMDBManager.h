//
//  FMDBManager.h
//  FMDBDemo
//
//  Created by 程庆春 on 07/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject

- (void) insertDataWithName:(NSString *)name age:(NSString*)age;
- (void) createTable;
- (void) updateDataWithName:(NSString *)name age:(NSString*) age;
@end

