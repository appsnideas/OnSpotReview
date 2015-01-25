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

@interface ReviewViewController ()

@end

@implementation ReviewViewController

@synthesize reviewEventList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
// Setting the background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"vAGZp.jpg"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *reviewQuestionsArray = reviewEventList.reviewQuestions.allValues[0];
    int y = 70;
    for (NSString *reviewQuestion in reviewQuestionsArray)
    {
        //NSLog(@"Y Value is: %d", y);
        //NSLog(@"%@", reviewQuestion);
        UITextView *reviewQuestion1 = [[UITextView alloc] initWithFrame:CGRectMake(10,y,300,50)];
        [reviewQuestion1 setFont:[UIFont systemFontOfSize:16]];
        reviewQuestion1.userInteractionEnabled = YES;
        reviewQuestion1.textColor = [UIColor blackColor];
        [reviewQuestion1 setBackgroundColor: [UIColor whiteColor]];
        [self.view addSubview:reviewQuestion1];
// Have to figure out hw to handle null questions.
        if (![reviewQuestion  isEqual: @"<null>"]) {
            reviewQuestion1.text = reviewQuestion;
            y = y+55;
        }
        else
        {
            continue;
                
        }
    }
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
