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
#import "ReviewPopUpViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize connector;
@synthesize gimbalServices;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.
    [FYX disableLocationUpdates];
    [FYX setAppId:@"4fe2e9514de0cfdd51bdc978185da2e355f9b35e9fd64ff3b413988398d29861"
        appSecret:@"d436bfd7cda586173395e7f215fa2ab1b3d696b118f51da5af12b90cfdc96383"
      callbackUrl:@"selfappsnideasonspotreview://authcode"];
    
//This will pause main thread (in splash screen) for x interval seconds.
    //[NSThread sleepForTimeInterval:5];

// Enabling Gimbal
    if(connector == NULL)
        connector = [QLContextCoreConnector new];
    
    [connector checkStatusAndOnEnabled: ^(QLContextConnectorPermissions *contextConnectorPermissions) {
        //NSLog(@"Already enabled");
        gimbalServices = [[GimbalServices alloc]init];
        [gimbalServices startService];
    }
    disabled:^(NSError *error)
    {
        //NSLog(@"Is not enabled");
        [connector enableFromViewController:self.window.rootViewController success:^
         {
             //NSLog(@"Gimbal enabled");
             gimbalServices = [[GimbalServices alloc]init];
             [gimbalServices startService];
             
         } failure:^(NSError *error) {
             //NSLog(@"Failed to initialize gimbal %@", error);
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
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(notification)
    {
        NSDictionary * userInfo = notification.userInfo;
        NSMutableDictionary * ourUserInfoDict = [OnSpotUtilities getUserInfoDict];
        
        for(NSString * key in userInfo)
        {
            //NSLog(@"user info key: %@", key);
            
            if ([ourUserInfoDict valueForKey:key])
            {
                //NSLog(@"Calling handleReviewNotif");
                [self handleReviewNotification:notification identifier:@"" eventId:key];
            }
        }
    }
    
    return YES;
}

// This method is called when a local Notification is responded without using notification Actions.
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary * userInfo = notification.userInfo;
    NSMutableDictionary * ourUserInfoDict = [OnSpotUtilities getUserInfoDict];
    
    for(NSString * key in userInfo)
    {
        //NSLog(@"user info key: %@", key);
        
        if ([ourUserInfoDict valueForKey:key])
        {
            //NSLog(@"Calling handleReviewNotif");
            [self handleReviewNotification:notification identifier:@"" eventId:key];
        }
    }
}

// This method is called when a local Notification is responded using notification Actions.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
    NSDictionary * userInfo = notification.userInfo;
    NSMutableDictionary * ourUserInfoDict = [OnSpotUtilities getUserInfoDict];
    
    for(NSString * key in userInfo)
    {
        //NSLog(@"user info key: %@", key);
        
        if ([ourUserInfoDict valueForKey:key])
        {
            //NSLog(@"Calling handleReviewNotif");
            [self handleReviewNotification:notification identifier:identifier eventId:key];
        }
    }
}

- (void) handleReviewNotification:(UILocalNotification *)notification identifier:(NSString *)identifier eventId: (NSString *)eventId
{
    EventList * eventList = [OnSpotUtilities getEventDetails:eventId];
    [OnSpotUtilities removeFromUserInfoDict:eventId];
    if([identifier isEqualToString:@"CLOSE_ID"])
    {
        return;
    }
    if([identifier isEqualToString:@"LATER_ID"])
    {
        [OnSpotUtilities scheduleNotificationWithItem:eventList interval:120 later:TRUE]; // Production
        //[OnSpotUtilities scheduleNotificationWithItem:eventList interval:1 later:TRUE];
        return;
    }
    
// Calling Review Pop Up.
    ReviewPopUpViewController *V2 = [[ReviewPopUpViewController alloc] init];
    [V2 setReviewEventList:[OnSpotUtilities getEventDetails:eventId]];
    V2.modalPresentationStyle = UIModalPresentationCurrentContext;
    V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    V2.preferredContentSize = CGSizeMake(325, 75);
    [self.window.rootViewController presentModalViewController:V2 animated:YES];
}

/*********************************      Methods Not Used    ************************
 
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
}
 
 *********************************      Methods Not Used    ************************/

@end
