//
//  OnSpotUtilities.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/26/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "EventList.h"

@interface OnSpotUtilities : NSObject

+ (NSString *) idForVendor;
+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (void)setMasterBGColor:(UITableViewController *)masterController;
+ (void)setBGColor: (UIViewController *)viewController;
+ (NSDate *) formattedDateTime: (NSString *)dateTime;
+ (void)scheduleNotificationWithItem:(EventList *)eventListPopUp interval:(int)minutesAfter  later:(BOOL) laterFlag;
+ (EventList *) getEventDetails:(NSString *)eventId;
+ (NSString *) getNextUserInfoIdentifier;
+ (void) removeFromUserInfoDict: (NSString *) key;
+ (NSMutableDictionary *) getUserInfoDict;

@end
