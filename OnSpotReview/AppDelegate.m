//
//  AppDelegate.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import <FYX/FYX.h>
#import "ReviewViewController.h"
#import <UIKit/UIKit.h>
#import <ContextCore/QLContextCoreConnector.h>
#import "OnSpotUtilities.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize connector;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.
    [FYX setAppId:@"4fe2e9514de0cfdd51bdc978185da2e355f9b35e9fd64ff3b413988398d29861"
        appSecret:@"d436bfd7cda586173395e7f215fa2ab1b3d696b118f51da5af12b90cfdc96383"
      callbackUrl:@"selfappsnideasonspotreview://authcode"];
    
//This will pause main thread (in splash screen) for x interval seconds.
    //[NSThread sleepForTimeInterval:5];

// Enabling Gimbal
    if(connector == NULL)
        connector = [QLContextCoreConnector new];
    
    [connector checkStatusAndOnEnabled: ^(QLContextConnectorPermissions *contextConnectorPermissions) {
        NSLog(@"Already enabled");
    }
    disabled:^(NSError *error)
    {
        //NSLog(@"Is not enabled");
        [connector enableFromViewController:self.window.rootViewController success:^
         {
             NSLog(@"Gimbal enabled");
         } failure:^(NSError *error) {
             NSLog(@"Failed to initialize gimbal %@", error);
         }];
    }];
    
// Asking user to register for notification from this app
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes: types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return YES;
}

// This method is called when a local Notification is responded without using notification Actions.
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([notification.userInfo[[MasterViewController getEventId]] isEqualToString:@"identifier"])
    {
        [self handleReviewNotification:notification identifier:@""];
    }
}
/*{
    NSLog(@"in didReceiveLocalNotification (App Delegate)");
    if ([notification.userInfo[[MasterViewController getEventId]] isEqualToString:@"identifier"])
    {
        NSLog(@"in didReceiveLocalNotification(app Delegate) - If begin");
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        ReviewViewController *result = NULL;
        if (navigationController.viewControllers)
        {
    //Look for the nav controller in tab bar views
            NSLog(@"In App Delegate did receive notification navigation if");
            for (UINavigationController *view in navigationController.viewControllers)
            {
                //when found, do the same thing to find the MasterViewController under the nav controller
                if ([view isKindOfClass:[UINavigationController class]])
                    for (UIViewController *view2 in view.viewControllers)
                    {
                        NSString *className = NSStringFromClass([view2 class]);
                        NSLog(@"UI Navigation Controller Class: %@", className);
                        if ([view2 isKindOfClass:[ReviewViewController class]])
                            result = (ReviewViewController *) view2;
                    }
            }
        }
        if (result != NULL)
        {
            [result setReviewEventList:[MasterViewController getEventDetails:[MasterViewController getEventId]]];
            [self.window.rootViewController presentViewController:result animated:YES completion:nil];
            NSLog(@"in didReceiveLocalNotification (app delegate) - if end");
        }
        else
        {
            NSLog(@" in 'didReceiveLocal..'  Result = NULL ELSE Loop");
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            ReviewViewController *add =
            [mainStoryboard instantiateViewControllerWithIdentifier:@"ReviewViewController"];
            [add setReviewEventList:[MasterViewController getEventDetails:[MasterViewController getEventId]]];
            //[self.window.rootViewController presentViewController:add animated:YES completion:nil];
            [self.window.rootViewController presentViewController:add animated:YES completion:nil];
        }
    }
}*/

// This method is called when a local Notification is responded using notification Actions.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
    if ([notification.userInfo[[MasterViewController getEventId]] isEqualToString:@"identifier"])
    {
        [self handleReviewNotification:notification identifier:identifier];
    }
}

- (void) handleReviewNotification:(UILocalNotification *)notification identifier:(NSString *)identifier
{
    EventList * eventList = [MasterViewController getEventDetails:[MasterViewController getEventId]];
    if([identifier isEqualToString:@"CLOSE_ID"])
    {
        return;
    }
    if([identifier isEqualToString:@"LATER_ID"])
    {
        [OnSpotUtilities scheduleNotificationWithItem:eventList interval:1];
        return;
    }
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    ReviewViewController *result = NULL;
    if (navigationController.viewControllers)
    {
        //look for the nav controller in tab bar views
        NSLog(@"In App Delegate Handle Action with identifier - if");
        for (UINavigationController *view in navigationController.viewControllers)
        {
            NSLog(@" View Class Name: %@", [[view class] class]);
            //when found, do the same thing to find the MasterViewController under the nav controller
            if ([view isKindOfClass:[ReviewViewController class]])
            {
                // NSLog(@"%@", [[view class] class]);
                for (UIViewController *view2 in view.viewControllers)
                {
                    NSString *className = NSStringFromClass([view2 class]);
                    //NSLog(@"UI Navigation Controller Class: %@", className);
                    if ([view2 isKindOfClass:[ReviewViewController class]])
                        result = (ReviewViewController *) view2;
                }
            }
        }
    }
    if (result != NULL)
    {
        [result setReviewEventList:[MasterViewController getEventDetails:[MasterViewController getEventId]]];
        [self.window.rootViewController presentViewController:result animated:YES completion:nil];
        NSLog(@"In App Delegate Handle Action with identifier - if end");
    }
    else{
        //NSLog(@" in 'handleActionWith..' Result = NULL ELSE Loop");
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        //NSLog(@"Main Story Board: %@", mainStoryboard);
        ReviewViewController *add =
        [mainStoryboard instantiateViewControllerWithIdentifier:@"ReviewViewController"];
        [add setReviewEventList:[MasterViewController getEventDetails:[MasterViewController getEventId]]];
        [self.window.rootViewController presentViewController:add animated:YES completion:nil];
    }
}

/*
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(UILocalNotification *)notification
{
    NSLog(@"in didReceiveRemoteNotification - App Delegate");
}

- (BOOL) pushNotificationOnOrOff
{
    if ([UIApplication instancesRespondToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        return ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]);
    } else {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        return (types & UIRemoteNotificationTypeAlert);
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
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
}*/

@end
