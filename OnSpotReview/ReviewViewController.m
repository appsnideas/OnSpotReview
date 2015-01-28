//
//  ReviewViewController.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/10/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "ReviewViewController.h"
#import "DetailViewController.h"
#import <UIKit/UIKit.h>
#import "EventList.h"
#import "DLStarRatingControl.h"
#import "OnSpotUtilities.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

@synthesize reviewEventList;
@synthesize ratings;
@synthesize ratingValues;

- (void)viewDidLoad
{
    [super viewDidLoad];
    ratings = [NSMutableDictionary new];
    ratingValues = [NSMutableDictionary new];
    //[ratings init];
// Yellow gradient Bakground
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YellowBG.jpg"]];
    
// Blue gradient Bakground
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BlueBG.jpg"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *reviewQuestionsArray = reviewEventList.reviewQuestions.allValues[0];
    int quesY = 0; //y = 70 (Was the previous start)
    int sliderY = 55;
    int cnt = 0;
    for (NSString *reviewQuestion in reviewQuestionsArray)
    {
        UITextView *reviewQuestion1 = [[UITextView alloc] initWithFrame:CGRectMake(0,quesY,320,70)];
        //[reviewQuestion1 setFont:[UIFont systemFontOfSize:20]];
        reviewQuestion1.userInteractionEnabled = NO;
        reviewQuestion1.textColor = [UIColor blackColor];
        reviewQuestion1.font = [UIFont boldSystemFontOfSize:18];
        reviewQuestion1.font = [UIFont italicSystemFontOfSize:18];
//Yellow Gradient
        //[reviewQuestion1 setBackgroundColor: [OnSpotUtilities colorWithHexString:@"FBE479"]];
//Blue Gradient
        [reviewQuestion1 setBackgroundColor: [OnSpotUtilities colorWithHexString:@"C143FB"]];
        [self.view addSubview:reviewQuestion1];
        reviewQuestion1.text = reviewQuestion;
        
        DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, sliderY, 320, 60) andStars:5 isFractional:NO];
        ratingControl.delegate = self;
        
//Yellow Gradient
       // [ratingControl setBackgroundColor: [OnSpotUtilities colorWithHexString:@"FBE479"]];
//Blue Gradient
        [ratingControl setBackgroundColor: [OnSpotUtilities colorWithHexString:@"C143FB"]];
        [self.view addSubview:ratingControl];
        quesY = quesY+111;
        sliderY = sliderY+111;
        
        NSValue *myKey = [NSValue valueWithNonretainedObject:ratingControl];
        [ratings setObject:reviewQuestion forKey:myKey];
        [ratingValues setValue:[NSNumber numberWithFloat:0.0] forKey:reviewQuestion];
        

        if (cnt % 2) {
//yellow Gradient
           // UIColor *altCellColor = [OnSpotUtilities colorWithHexString:@"EACB44"];
// Blue Gradient
            UIColor *altCellColor = [OnSpotUtilities colorWithHexString:@"C36DFC"];
            reviewQuestion1.backgroundColor = altCellColor;
            ratingControl.backgroundColor = altCellColor;
        }
        cnt = cnt+1;
        if (cnt == 4){
            break;
        }
        
/*// Have to figure out hw to handle null questions.
        if (![reviewQuestion  isEqual: @"<null>"]) {
            reviewQuestion1.text = reviewQuestion;
            quesY = quesY+55;
        }
        else
        {
            continue;
                
        }*/
    }
    
    UIButton *submit= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submit addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submit setFrame:CGRectMake(90, 455, 140, 40)];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setExclusiveTouch:YES];
    submit.layer.cornerRadius = 1;
    submit.layer.borderWidth = 1;
    //submit.layer.borderColor = [UIColor blueColor].CGColor;
    submit.backgroundColor = [OnSpotUtilities colorWithHexString:@"587EAA"];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submit];
}

// Adding Submit Buton
- (void) buttonClicked:(UIButton*)sender
{
    NSLog(@"Count%lu", (unsigned long)ratings.count);
    NSLog(@"All Keys: %@",ratings.allKeys);
    NSLog(@"All Values: %@",ratings.allValues);
    for(NSString * key in ratingValues.allKeys)
    {
        NSLog(@"Question: %@ -> Rating: %@",key, [ratingValues valueForKey:key]);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newRating:(DLStarRatingControl *)control :(float)rating {
    NSValue *myKey = [NSValue valueWithNonretainedObject:control];
    NSString * reviewQuestion = [ratings objectForKey:myKey];
    [ratingValues setValue:[NSNumber numberWithFloat:rating] forKey:reviewQuestion];
    
}

/*****************      Unused but useful code  **********************************/

/*
-(void)boldFontForLabel:(UITextView *)revQuestion1{
    UIFont *currentFont = revQuestion1.font;
    UIFont *newFont = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",currentFont.fontName] size:currentFont.pointSize];
    revQuestion1.font = newFont;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;

}
*/

@end
