//
//  ReviewViewController.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/10/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "ReviewViewController.h"
#import "DetailViewController.h"
//#import "MasterViewController.h"
#import "EventList.h"
#import "DLStarRatingControl.h"
#import "OnSpotUtilities.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

@synthesize reviewEventList;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"vAGZp.jpg"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *reviewQuestionsArray = reviewEventList.reviewQuestions.allValues[0];
    int quesY = 65;
    int sliderY = 120;
    int cnt = 0;
    for (NSString *reviewQuestion in reviewQuestionsArray)
    {
        UITextView *reviewQuestion1 = [[UITextView alloc] initWithFrame:CGRectMake(0,quesY,320,60)];
        [reviewQuestion1 setFont:[UIFont systemFontOfSize:20]];
        reviewQuestion1.userInteractionEnabled = NO;
        reviewQuestion1.textColor = [UIColor blackColor];
        //reviewQuestion1.font = [UIFont fontWithName:@"Garamond" size:30.0];
        [reviewQuestion1 setBackgroundColor: [OnSpotUtilities colorWithHexString:@"6494B8"]];
        [self.view addSubview:reviewQuestion1];
        reviewQuestion1.text = reviewQuestion;
        
        DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, sliderY, 320, 60) andStars:5 isFractional:NO];
        [ratingControl setBackgroundColor: [OnSpotUtilities colorWithHexString:@"6494B8"]];
        [self.view addSubview:ratingControl];
        quesY = quesY+111;
        sliderY = sliderY+111;
        if (cnt % 2) {
            UIColor *altCellColor = [OnSpotUtilities colorWithHexString:@"4DB5EC"];
            reviewQuestion1.backgroundColor = altCellColor;
            ratingControl.backgroundColor = altCellColor;
        }
        cnt = cnt+1;
        if (cnt == 4){
            break;
        }
        
        
/*
// Slider for answers:
        CGRect frame = CGRectMake(10, sliderY, 300, 10);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 0.0;
        slider.maximumValue = 50.0;
        slider.continuous = YES;
        slider.value = 25.0;
        [self.view addSubview:slider];
        quesY = quesY+65;
        sliderY = sliderY+65;

// Have to figure out hw to handle null questions.
        if (![reviewQuestion  isEqual: @"<null>"]) {
            reviewQuestion1.text = reviewQuestion;
            quesY = quesY+55;
        }
        else
        {
            continue;
                
        }*/
    }
}

-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
