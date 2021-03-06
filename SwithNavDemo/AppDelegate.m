//
//  AppDelegate.m
//  SwithNavDemo
//
//  Created by mahong on 17/3/1.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "OneViewController.h"
#import "ThreeViewController.h"
#import "TwoViewController.h"
#import "SpotlightHandler.h"
#import <CoreSpotlight/CoreSpotlight.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNav:) name:@"change" object:nil];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    nav1.tabBarItem.title = @"1";
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[OneViewController new]];
    nav2.tabBarItem.title = @"2";
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[TwoViewController new]];
    nav3.tabBarItem.title = @"3";
    
    self.mainTabBar = [[UITabBarController alloc] init];
    [self.mainTabBar setViewControllers:@[nav1,nav2,nav3]];
    self.window.rootViewController = self.mainTabBar;
    
    [SpotlightHandler setSpotlight];
    
    return YES;
}

- (void)changeNav:(NSNotification *)notification
{
    NSNumber *number = notification.object;
    NSInteger index = number.integerValue;
    
    UINavigationController *replaceNav = [[UINavigationController alloc] initWithRootViewController:[ThreeViewController new]];
    replaceNav.tabBarItem.title = @"replace";
    NSMutableArray *controllers = [self.mainTabBar.viewControllers mutableCopy];
    [controllers replaceObjectAtIndex:index withObject:replaceNav];
    NSArray *newControllers = [controllers copy];
    [self.mainTabBar setViewControllers:newControllers animated:NO];
    
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    if ([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
        /** 获取searchItem 中的唯一 id */
        NSString *uniqueIdentifier = [userActivity.userInfo objectForKey:CSSearchableItemActivityIdentifier];
        NSLog(@"您点击了 == %@",uniqueIdentifier);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:uniqueIdentifier]];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"url == %@",url.absoluteString);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
