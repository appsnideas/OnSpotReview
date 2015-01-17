//
//  MasterViewController.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

// We need UIKIT becaasue everything is part of UI Kit
#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSArray * eventList; // This is used for hardcoded data
@property (strong, nonatomic) NSMutableArray * eventList1; // This is used for non- hardcoded data
//@property (strong, nonatomic) NSMutableArray * eventList2; //
@property (strong, nonatomic) NSArray * detailList;

@end

