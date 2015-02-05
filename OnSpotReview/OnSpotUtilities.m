//
//  OnSpotUtilities.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/26/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "OnSpotUtilities.h"
@import UIKit;
#import <UIKit/UIKit.h>
#import <uuid/uuid.h>
#import "EventList.h"
#import "MasterViewController.h"

@implementation OnSpotUtilities

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(void) setMasterBGColor:(UITableViewController *)masterController;{
    
    [masterController.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YellowBG.jpg"]]];
    
}

+(void) setBGColor:(UIViewController *)viewController;{
    
    viewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YellowBG.jpg"]];
    
}


+ (NSString *) idForVendor
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
    
}

+ (NSDate *) formattedDateTime: (NSString *)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:posix];
    NSDate *formattedDateTime = [dateFormatter dateFromString:dateTime];
    [dateFormatter setDateFormat:@"MMM dd yyyy 'at' hh:mm a"];
    return formattedDateTime;
}

+ (void)scheduleNotificationWithItem:(EventList *)eventListPopUp interval:(int)minutesAfter
{
//    NSDate *itemDate = [OnSpotUtilities formattedDateTime:item.dateTime];
    NSLog(@"in scheduleNotificationWithItem - begin");
    NSDate *itemDate = [NSDate date];
    /***********************************************************/
    // Interactive Notifications Alert - Registering an Action
    NSLog(@"Event Date and Time schedule: %@",itemDate);
    UIMutableUserNotificationAction *review = [[UIMutableUserNotificationAction alloc] init];
    UIMutableUserNotificationAction *later = [[UIMutableUserNotificationAction alloc] init];
    review.identifier = @"REVIEW_ID";//item.eventId; // The id passed when the user selects the action
    later.identifier = @"CLOSE_ID";//item.eventId;
    review.title = NSLocalizedString(@"Sure!..",nil);
    later.title = NSLocalizedString(@"Close",nil);
    review.activationMode = UIUserNotificationActivationModeForeground;
    later.activationMode = UIUserNotificationActivationModeBackground;
    review.destructive = NO; // If YES, then the action is red
    later.destructive = NO;
    review.authenticationRequired = YES;
    later.authenticationRequired = NO;// Whether the user must authenticate to execute the action
    
    // Interactive Notifications Category - Creating a Category of Actions
    UIMutableUserNotificationCategory *firstResponse = [[UIMutableUserNotificationCategory alloc] init];
    firstResponse.identifier = @"REVIEW_CATEGORY"; // Identifier passed in the payload
    //[firstResponse setActions:@[review, later] forContext:UIUserNotificationActionContextDefault];
    [firstResponse setActions:@[review, later] forContext:UIUserNotificationActionContextMinimal];
    
    // Registering Categories
    NSSet *categories = [NSSet setWithObjects:firstResponse, nil];
    NSUInteger types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound; // Add badge, sound, or alerts here
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    // Local Notifications
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.category = @"REVIEW_CATEGORY";
    [localNotif setUserInfo:@{eventListPopUp.eventId : @"identifier"}];
    //[localNotif setUserInfo:@{eventListPopUp.eventId : eventListPopUp}];
    localNotif.fireDate = [itemDate dateByAddingTimeInterval:+(minutesAfter*60)];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ would love to get your feedback for the event.", nil),eventListPopUp.eventName];
    //localNotif.alertAction = NSLocalizedString(@"Yes", nil);
    //localNotif. = NSLocalizedString(@"Event Review", nil);
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    //localNotif.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [MasterViewController setEventId: eventListPopUp.eventId];
    NSLog(@"in scheduleNotificationWithItem - end");
}



@end
