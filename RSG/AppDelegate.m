//
//  AppDelegate.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "AppDelegate.h"
#import "Colors.h"
#import "TestFairy.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPRequestOperationLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBarStyle: UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor: OrangeColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : WhiteColor}];
    [[UINavigationBar appearance] setTintColor: WhiteColor];
    [[UIBarButtonItem appearance] setTintColor: WhiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor: WhiteColor];
    [[UISlider appearance] setThumbImage: [UIImage imageNamed:@"yoursliderimage.png"] forState:UIControlStateNormal];
    
#ifdef DEBUG
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
#endif
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled: YES];
    //[TestFairy begin:@"2177b75eb4a83dfe8a573317e7d3ea55f5a137a1"];
    
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
