//
//  AppDelegate.h
//  DIPESHCHROMECAST
//
//  Created by Dipesh Pokhrel on 04/09/18.
//  Copyright © 2018 Dipesh Pokhrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (BOOL)castControlBarsEnabled ;
- (void)setCastControlBarsEnabled:(BOOL)notificationsEnabled;
@end

