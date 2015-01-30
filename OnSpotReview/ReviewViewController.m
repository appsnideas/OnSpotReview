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
        reviewQuestion1.textColor = [UIColor whiteColor];
        reviewQuestion1.font = [UIFont boldSystemFontOfSize:18];
        reviewQuestion1.font = [UIFont italicSystemFontOfSize:18];
//Yellow Gradient
        //[reviewQuestion1 setBackgroundColor: [OnSpotUtilities colorWithHexString:@"FBE479"]];
//Blue Gradient
        [reviewQuestion1 setBackgroundColor: [OnSpotUtilities colorWithHexString:@"C463FB"]];
        [self.view addSubview:reviewQuestion1];
        reviewQuestion1.text = reviewQuestion;
        
        DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, sliderY, 320, 60) andStars:5 isFractional:NO];
        ratingControl.delegate = self;
        
//Yellow Gradient
       // [ratingControl setBackgroundColor: [OnSpotUtilities colorWithHexString:@"FBE479"]];
//Blue Gradient
        [ratingControl setBackgroundColor: [OnSpotUtilities colorWithHexString:@"C463FB"]];
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
            UIColor *altCellColor = [OnSpotUtilities colorWithHexString:@"D46BFA"];
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
// Adding Submmit button and setting UI parameters.
    UIButton *submit= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submit addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submit setFrame:CGRectMake(90, 455, 140, 40)];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setExclusiveTouch:YES];
    submit.layer.cornerRadius = 1;
    submit.layer.borderWidth = 1;
    submit.backgroundColor = [OnSpotUtilities colorWithHexString:@"587EAA"]; // Matching the "review" button color
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submit];
}

//  Submit Buton Action - Collecting the ratings, Creating JSON and posting it to server.
- (void) buttonClicked:(UIButton*)sender
{
// Creating the jSON Mutable String which can be appended with exact format as needed by server.
    
    NSData *jsonData = [[NSData alloc]init]; // Declaring NSData object for jSON.
    NSMutableString *jsonString = [[NSMutableString alloc]initWithString:@"{\"answers\":["]; // Declaring and initiating the jSON String.
    int count = 0; // Counter to control the ending elements of JSON.
    for(NSString * key in ratingValues.allKeys)
    {
        //NSLog(@"Question: %@ -> Rating: %@",key, [NSString stringWithFormat:@"%@",[ratingValues valueForKey:key]]);
        ++count;
        if(count == [ratingValues count])
            [jsonString appendString:[NSString stringWithFormat:@"{\"question\":\"%@\",\"answer\":\"%@\"}",key,[ratingValues valueForKey:key]]];
        else
            [jsonString appendString:[NSString stringWithFormat:@"{\"question\":\"%@\",\"answer\":\"%@\"},",key,[ratingValues valueForKey:key]]];
        
    }
    [jsonString appendString:@"],"];
    [jsonString appendString:[NSString stringWithFormat:@"\"deviceID\":\"%@\"}",[OnSpotUtilities idForVendor]]];
    NSString *eventId = reviewEventList.eventId;
// End of jSON string creation. below is getting event ID.

//jSON post - Creating Json (NS)Data from the above string and URL from Data.
    jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *strData = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"JSON Data%@", strData);
    NSString *urlString = [NSString stringWithFormat:@"https://damp-journey-8712.herokuapp.com/osrevents/%@/osreventreviews", eventId];
    NSURL *reviewURL = [NSURL URLWithString:urlString];
  // Creating request and posting to server.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:reviewURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
  // Getting response from server for the posted data.
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    //NSLog(@"Request: %@", request);
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];
    
    if (errorReturned) {
        NSLog(@"Error: %@, Response: %@",errorReturned, theResponse);
    }
    else
    {
        NSError *jsonParsingError = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];
    }
    
}
// End JSON Post and button click code

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// DLStar rating project to use the stars and get the values
-(void)newRating:(DLStarRatingControl *)control :(float)rating {
    NSValue *myKey = [NSValue valueWithNonretainedObject:control];
    NSString * reviewQuestion = [ratings objectForKey:myKey];
    [ratingValues setValue:[NSNumber numberWithFloat:rating] forKey:reviewQuestion];
    
}

@end
