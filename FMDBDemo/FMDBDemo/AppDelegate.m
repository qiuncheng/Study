//
//  AppDelegate.m
//  FMDBDemo
//
//  Created by 程庆春 on 06/11/2016.
//  Copyright © 2016 qiuncheng.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self createCopyOfDatabaseIfNeeded];
    return YES;
}

- (void) createCopyOfDatabaseIfNeeded {
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *appDBPath = [documentDirectory stringByAppendingPathComponent:@"Student.sqlite"];
    success = [fileManager fileExistsAtPath:appDBPath];
    if (success) {
        return ;
    }
    NSString *defaultPath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"Student.sqlite"];
    success = [fileManager copyItemAtPath:defaultPath toPath:appDBPath error:&error];
    if (!success) {
        NSAssert(0, @"Failed to create writable database file with message '%@'", error.localizedDescription);
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
