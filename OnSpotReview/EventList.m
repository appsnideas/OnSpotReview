//
//  EventList.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "EventList.h"

@implementation EventList

// Implementsion code for getter and setter methods (shown only for "title" instance variable)
/*
 - (void) setTitle:(NSString *)_title {
 title = _title;
 }
 - (NSString *) title {
 return title;
 }
 */

// When using properties, all you need to do is "sysnthesize the property and we are done..here you go.
@synthesize title;
@synthesize author;
@synthesize date;

/* Here in the .m, we initialize the designated Initializer
 We declare/initialize "Self" indicating self is this class and its super class which is NSObject */

- (id) initWithTitle: (NSString *) _title{
    self = [super init];
    // Did not understand this..
    
    // Verifying is 'Self' is working.
    if (self){
        self.title = _title;
        self.thumbnail = nil;
        self.author = nil;
        
    }
    return self;
}

/* Here in the .m, we initialize the convienience constructor
 We declare/initialize "Self" indicating self is this class and its super class which is NSObject */
+ (id) eventListWithTitle: (NSString *) title{
    return [[self alloc] initWithTitle:title];
}
- (NSURL *) thumbnailURL {
    //NSLog(@"%@",[self.thumbnail class]);
    return [NSURL URLWithString:self.thumbnail];
}
- (NSString *) formattedDate {
    // Date Formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formattedDate = [dateFormatter dateFromString:self.date];
    [dateFormatter setDateFormat:@"EE MMM,dd yyyy"];
    return [dateFormatter stringFromDate:formattedDate];
}

@end
