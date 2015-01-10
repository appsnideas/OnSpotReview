//
//  EventList.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventList : NSObject{
    NSString *title;
    NSString *date;
    NSString *author;
}
// Getters and Setters
/*
 - (void) setTitle: (NSString *)title;
 - (NSString *) title;
 
 - (void) setAuthor: (NSString *)author;
 - (NSString *) author;
 
 - (void) setDate: (NSString *)date;
 - (NSString *) date;
 */

// Instead of getter and setter as below....we can use properties. Properties equivalent to getters and setters above
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSURL *URL;

// These doesn;t need Strong/weak because these are primitive types.
@property (nonatomic) int views;
@property (nonatomic) BOOL unread;

/* Designated Initializer and convinience constructors. Thease are like init and alloc resply.. We can decide what propereties are required when initializing the object of this class and put them in the designated initializer*/
//Designated initialiuzer
- (id) initWithTitle: (NSString *) title;
+ (id) eventListWithTitle: (NSString *) title;

- (NSURL *) thumbnailURL;

- (NSString *) formattedDate;

@end
