//
//  EventList.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "EventList.h"

@implementation EventList

// When using properties, all you need to do is "sysnthesize the property and we are done..here you go.
@synthesize eventName;
@synthesize address;
@synthesize dateTime;
@synthesize description;
@synthesize eventId;
@synthesize type;
@synthesize contactName;
@synthesize phone;
@synthesize addressStreet1;
@synthesize addressStreet2;
@synthesize city;
@synthesize state;
@synthesize zipcode;
@synthesize Country;
@synthesize thumbnail;
@synthesize website;
@synthesize ticketingURL;
@synthesize longitude;
@synthesize latitude;
@synthesize reviewQuestions;
@synthesize reviewAnswers;
//@synthesize reviewQuestionsArray;
//@synthesize reviewQuestionId;
//@synthesize reviewQuestion;

/* Here in the .m, we initialize the designated Initializer
 We declare/initialize "Self" indicating self is this class and its super class which is NSObject */

- (id) initWithName: (NSString *) _title{
    self = [super init];
    // Did not understand this..
    
    // Verifying is 'Self' is working.
    if (self){
        self.eventName = _title;
        self.address = nil;
    }
    return self;
}

/* Here in the .m, we initialize the convienience constructor
 We declare/initialize "Self" indicating self is this class and its super class which is NSObject */
+ (id) eventListWithName: (NSString *) title{
    return [[self alloc] initWithName:title];
}

- (NSURL *) websiteURL
{
    //return [NSURL URLWithString:self.website];
    return [NSURL URLWithString:self.website];
}

/*- (NSURL *) ticketingURL
{
    //return [NSURL URLWithString:self.website];
    return [NSURL URLWithString:self.ticketingURL];
}
*/
- (NSString *) formattedDate {
    // Date Formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:posix];
    NSDate *formattedDate = [dateFormatter dateFromString:self.dateTime];
    [dateFormatter setDateFormat:@"MMM dd yyyy 'at' hh:mm a"];
    return [dateFormatter stringFromDate:formattedDate];
}

@end
