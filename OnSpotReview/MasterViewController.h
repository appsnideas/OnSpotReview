//
//  MasterViewController.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

// We need UIKIT becaasue everything is part of UI Kit
#import <UIKit/UIKit.h>
#import "EventList.h"

@interface MasterViewController : UITableViewController

//@property (strong, nonatomic) NSArray * eventList; // This is used for hardcoded data
@property (strong, nonatomic) NSMutableArray * eventList1; // Array for parsed JSON coming from Event URL.
@property (strong, nonatomic) NSArray * detailList;
//@property (nonatomic) BOOL sightingFlag;
@property (strong, nonatomic) EventList * eventListPopUp;

//+ (NSString *) getEventId;
//+ (void) setEventId : (NSString *)id;

@end

