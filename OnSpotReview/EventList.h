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

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSURL *URL;

// These doesn;t need Strong/weak because these are primitive types.
@property (nonatomic) int views;
@property (nonatomic) BOOL unread;

/*  Designated Initializer - This is used to initialize the instance of the class (object) - ex: init
    This can also be used to initialize the instance with specific required instance variables (if any) Ex: initWithObjects.
    Also, a designated initializer should return "id"(general purpose notation of the instance).
 
 Convienience Constructor - Every object initialization should also be allocated. Combining 'allocation' and 'initialization' in one step is called "Convienience Constructor".
 Ex: DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
 */

//Designated initializer
- (id) initWithTitle: (NSString *) title;
+ (id) eventListWithTitle: (NSString *) title;

- (NSURL *) thumbnailURL;

- (NSString *) formattedDate;

@end
