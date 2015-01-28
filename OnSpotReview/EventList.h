//
//  EventList.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventList : NSObject{

}

// Event Parameters Declaration passed by event URL
@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *addressStreet1;
@property (nonatomic, strong) NSString *addressStreet2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *Country;
@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSString *thumbnail;
//@property (nonatomic, strong) NSURL *website;
@property (nonatomic, strong) NSString *website;
//@property (nonatomic, strong) NSURL *ticketingURL;
@property (nonatomic, strong) NSArray *ticketingURL;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

// Review Questions dictionary
@property (nonatomic, strong) NSDictionary *reviewQuestions;
//@property (nonatomic, strong) NSDictionary *reviewAnswers;


/*  Designated Initializer - This is used to initialize the instance of the class (object) - ex: init
    This can also be used to initialize the instance with specific required instance variables (if any) Ex: initWithObjects.
    Also, a designated initializer should return "id"(general purpose notation of the instance).
 
 Convienience Constructor - Every object initialization should also be allocated. Combining 'allocation' and 'initialization' in one step is called "Convienience Constructor".
 Ex: DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
 */

//Designated initializer
- (id) initWithName: (NSString *) name;

+ (id) eventListWithName: (NSString *) name;

//- (NSURL *) ticketingURL;

- (NSURL *) websiteURL;

- (NSString *) formattedDate;

@end
