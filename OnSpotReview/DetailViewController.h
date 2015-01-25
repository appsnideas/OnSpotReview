//
//  DetailViewController.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventList.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) EventList *detailEventList;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)review:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextView *eventDetailLabel;

@end

