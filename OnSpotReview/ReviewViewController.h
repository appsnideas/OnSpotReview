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
@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property(strong, nonatomic) NSString *testLabelText;
@property (strong, nonatomic) EventList *reviewEventList;
@property (strong, nonatomic) NSMutableDictionary *ratings;
@property (strong, nonatomic) NSMutableDictionary *ratingValues;


//@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion1;
//@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion2;
//@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion3;
//@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion4;
//@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion5;

- (void) buttonClicked:(UIButton*)sender;

@end
