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

static NSMutableDictionary * reviewNotificationDict = NULL;
static int count = 0;

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

+ (void)scheduleNotificationWithItem:(EventList *)eventList interval:(int)minutesAfter later:(BOOL) laterFlag
{
//    NSDate *itemDate = [OnSpotUtilities formattedDateTime:item.dateTime];
    
    if ([reviewNotificationDict valueForKey:eventList.eventId])
        return;
    //NSLog(@"in scheduleNotificationWithItem - begin");
    NSDate *itemDate = NULL;
    NSDate * currDate = [NSDate date];
    if(laterFlag)
        itemDate= [NSDate date];
    else
    {
        itemDate = [OnSpotUtilities formattedDateTime:eventList.dateTime];
        if([currDate earlierDate:itemDate] == currDate)
            return;
    }

// Interactive Notifications Alert - Registering an Action
    //NSLog(@"Event Date and Time schedule: %@",itemDate);
    UIMutableUserNotificationAction *review = [[UIMutableUserNotificationAction alloc] init];
    UIMutableUserNotificationAction *later = [[UIMutableUserNotificationAction alloc] init];
    UIMutableUserNotificationAction *close = [[UIMutableUserNotificationAction alloc] init];
    
    review.identifier = @"REVIEW_ID";//item.eventId; // The id passed when the user selects the action
    later.identifier = @"LATER_ID";//item.eventId;
    close.identifier = @"CLOSE_ID";
    
    review.title = NSLocalizedString(@"Sure!..",nil);
    later.title = NSLocalizedString(@"Later",nil);
    close.title =NSLocalizedString(@"Close",nil);

    review.activationMode = UIUserNotificationActivationModeForeground;
    later.activationMode = UIUserNotificationActivationModeBackground;
    close.activationMode = UIUserNotificationActivationModeBackground;
    
    review.destructive = NO; // If YES, then the action is red
    later.destructive = NO;
    close.destructive = NO;
    
    review.authenticationRequired = YES;
    later.authenticationRequired = NO;// Whether the user must authenticate to execute the action
    close.authenticationRequired = NO;
    
// Interactive Notifications Category - Creating a Category of Actions
    UIMutableUserNotificationCategory *firstResponse = [[UIMutableUserNotificationCategory alloc] init];
    firstResponse.identifier = @"REVIEW_CATEGORY"; // Identifier passed in the payload
    //[firstResponse setActions:@[review, later] forContext:UIUserNotificationActionContextDefault];
    if(laterFlag)
        [firstResponse setActions:@[review, close] forContext:UIUserNotificationActionContextMinimal];
    else
        [firstResponse setActions:@[review, later] forContext:UIUserNotificationActionContextMinimal];
    
// Registering Categories
    NSSet *categories = [NSSet setWithObjects:firstResponse, nil];
    
    NSUInteger types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
// Local Notifications
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.category = @"REVIEW_CATEGORY";
    NSString * userInfoId = [OnSpotUtilities getNextUserInfoIdentifier];
    [localNotif setUserInfo:@{eventList.eventId : userInfoId}];
    //[localNotif setUserInfo:@{eventListPopUp.eventId : eventListPopUp}];
    localNotif.fireDate = [itemDate dateByAddingTimeInterval:+(minutesAfter*60)];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ would love to get your feedback for the event.", nil),eventList.eventName];
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    if(reviewNotificationDict == NULL)
        reviewNotificationDict = [[NSMutableDictionary alloc] init];
    [reviewNotificationDict setObject:userInfoId forKey:eventList.eventId];
}

+ (void) removeFromUserInfoDict: (NSString *) key
{
    if(reviewNotificationDict)
    {
        [reviewNotificationDict removeObjectForKey:key];
    }
}

+ (NSMutableDictionary *) getUserInfoDict
{
    return reviewNotificationDict;
}

+ (NSString *) getNextUserInfoIdentifier
{
    return [NSString stringWithFormat:@"identifier%d", ++count];
}

+ (EventList *) getEventDetails:(NSString *)eventId
{
    // Grabbing data from URL
    NSString * eventUrl = [NSString stringWithFormat:@"https://damp-journey-8712.herokuapp.com/osrevents/%@",eventId];
    NSURL *eventsURL = [NSURL URLWithString:eventUrl];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;
    
// Checking if JSON Data is null
    if ([jsonData isEqual:nil] || jsonData == NULL) {
        //NSLog(@"No json data");
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                             message:@"No Jason Data Found"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Dismiss"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        return NULL;
    }
    
// Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    //self.eventList1 = [NSMutableArray array];
    EventList *eventLists = [EventList eventListWithName:[eventDictionary objectForKey:@"name"]];
    
// Gathering EventId and Time of the Event
    NSString *eventTime = [[NSString alloc]init];
    if (![eventDictionary objectForKey:@"_Id"])
    {
        eventLists.eventId = [eventDictionary objectForKey:@"_id"];
    }
    if ([eventDictionary objectForKey:@"eventDateAndTime"] != NULL)
    {
        eventLists.dateTime = [eventDictionary objectForKey:@"eventDateAndTime"];
        eventTime = [NSString stringWithFormat:@"Date: %@",[eventLists formattedDate]];
        //NSLog(@"Event Date and Time: %@",eventTime);
    }
    //NSLog(@"Event Id: %@", eventLists.eventId);
    
//Populating data dictionary for review questions.
    NSString *reviewQuestionId = [eventDictionary valueForKeyPath:@"reviewquestions.id"];
    NSString *reviewQuestion = [eventDictionary valueForKeyPath:@"reviewquestions.question"];
    eventLists.reviewQuestions = [NSDictionary dictionaryWithObjectsAndKeys:reviewQuestion, reviewQuestionId, nil];
    return eventLists;
}


@end
