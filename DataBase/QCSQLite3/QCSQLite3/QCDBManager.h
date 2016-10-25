//
//  QCDBManager.h
//  QCSQLite3
//
//  Created by 程庆春 on 2016/10/25.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCDBManager : NSObject
{
    NSString *dataBasePath;
}
+ (QCDBManager *) sharedInstance;
-(BOOL) createDB;
-(BOOL) saveData: (NSString *) registerNumber name:(NSString* ) name department:(NSString *)department year:(NSString *)year;
-(NSArray *) findByRegisterNumber:(NSString *)registerNumber;

@end
