//
//  ReviewViewController.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/10/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventList.h"
#import "DLStarRatingControl.h"

@interface ReviewViewController : UIViewController<DLStarRatingDelegate>

@property (strong, nonatomic) EventList *reviewEventList;
@property (strong, nonatomic) NSMutableDictionary *ratings;
@property (strong, nonatomic) NSMutableDictionary *ratingValues;


- (void) buttonClicked:(UIButton*)sender;

@end
