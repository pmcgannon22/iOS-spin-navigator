//
//  MSAppDelegate.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/14/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "MSAppDelegate.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [mainWindow makeKeyAndVisible];
    float y = 100;
    float w = 150;
    
    UIView *bubbleWrap = [[UIView alloc] initWithFrame:CGRectMake(mainWindow.frame.size.width - w, y, w, 175)];
    bubbleWrap.backgroundColor = [UIColor blackColor];
    bubbleWrap.alpha = 0.25;
    [mainWindow addSubview:bubbleWrap];
    [mainWindow bringSubviewToFront:bubbleWrap];

    MSMainBubbleView *bubble = [[MSMainBubbleView alloc] initWithFrame:CGRectMake(w-20, 40, 70, 70) icon:@"gray.png"];
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:bubble action:@selector(handlePan:)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:bubble action:@selector(bubbleTapped:)];
    [bubble addGestureRecognizer:tap];
    pgr.cancelsTouchesInView = NO;
    [bubbleWrap addGestureRecognizer:pgr];
    [bubbleWrap addSubview:bubble];
    [bubble addActionIcon:@"messenger-icon" tapCommand:^{
        NSLog(@"asdfasdf");
    }];
    
    [bubble addActionIcon:@"messenger-icon" tapCommand:^{
        NSLog(@"asdfasdf");
    }];
    
    [bubble addActionIcon:@"messenger-icon" tapCommand:^{
        NSLog(@"asdfasdf");
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
