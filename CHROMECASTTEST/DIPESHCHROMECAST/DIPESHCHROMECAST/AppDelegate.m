//
//  AppDelegate.m
//  DIPESHCHROMECAST
//
//  Created by Dipesh Pokhrel on 04/09/18.
//  Copyright © 2018 Dipesh Pokhrel. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleCast/GoogleCast.h>

@interface AppDelegate ()<GCKLoggerDelegate>



@end

@implementation AppDelegate

static NSString *const kReceiverAppID = @"4F8B3483";
static const BOOL kDebugLoggingEnabled = YES;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    GCKCastOptions *options =
    [[GCKCastOptions alloc] initWithReceiverApplicationID:kGCKDefaultMediaReceiverApplicationID];
    [GCKCastContext setSharedInstanceWithOptions:options];
    UIStoryboard *appStoryboard =
    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationController =
    [appStoryboard instantiateViewControllerWithIdentifier:@"MainNavigation"];
    GCKUICastContainerViewController *castContainerVC;
    castContainerVC = [[GCKCastContext sharedInstance]
                       createCastContainerControllerForViewController:navigationController];
    castContainerVC.miniMediaControlsItemEnabled = YES;
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = castContainerVC;
    [self.window makeKeyAndVisible];

    [GCKLogger sharedInstance].delegate = self;
    [GCKCastContext sharedInstance].useDefaultExpandedMediaControls = YES;
    [[GCKLogger sharedInstance] setDelegate:self];
    
    return YES;
}

#pragma mark - GCKLoggerDelegate

- (void)logMessage:(NSString *)message fromFunction:(NSString *)function {
    NSLog(@"%@  %@", function, message);
}

- (void)setCastControlBarsEnabled:(BOOL)notificationsEnabled {
    GCKUICastContainerViewController *castContainerVC;
    castContainerVC =
    (GCKUICastContainerViewController *)self.window.rootViewController;
    castContainerVC.miniMediaControlsItemEnabled = notificationsEnabled;
}

- (BOOL)castControlBarsEnabled {
    GCKUICastContainerViewController *castContainerVC;
    castContainerVC =
    (GCKUICastContainerViewController *)self.window.rootViewController;
    return castContainerVC.miniMediaControlsItemEnabled;
}

#pragma mark - GCKLoggerDelegate

//- (void)logMessage:(NSString *)message fromFunction:(NSString *)function {
//    if (kDebugLoggingEnabled) {
//        NSLog(@"%@  %@", function, message);
//    }
//}


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
    
    [[GCKCastContext sharedInstance].sessionManager endSession];
}


@end
