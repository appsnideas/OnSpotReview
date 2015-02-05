//
//  ReviewPopUpControllerViewController.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 2/5/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventList.h"
#import "DLStarRatingControl.h"

@interface ReviewPopUpViewController : UIViewController<DLStarRatingDelegate>

@property (strong, nonatomic) EventList *reviewEventList;
@property (strong, nonatomic) NSMutableDictionary *ratings;
@property (strong, nonatomic) NSMutableDictionary *ratingValues;


- (void) buttonClicked:(UIButton*)sender;
@end
