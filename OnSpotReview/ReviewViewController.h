//
//  ReviewViewController.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/10/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property(strong, nonatomic) NSString *testLabelText;

@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion1;
@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion2;
@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion3;
@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion4;
@property (strong, nonatomic) IBOutlet UITextView *reviewQuestion5;

@end
