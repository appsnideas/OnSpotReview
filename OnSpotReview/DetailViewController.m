//
//  DetailViewController.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ReviewViewController.h"
#import "EventList.h"
#import "Foundation/Foundation.h"
#import "UIKit/UIKitDefines.h"
#import "OnSpotUtilities.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailEventList;

//- (IBAction)chekIn:(id)sender { }
- (IBAction)review:(id)sender { }

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
       // [self configureView];
    }
}

- (void)configureView
{/*
// Update the user interface for the detail item.
    if (self.detailItem)
    {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }*/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    //[ratings init];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                               self.view.frame.size.width,
                                                                               self.view.frame.size.height)];

    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.userInteractionEnabled = YES;
    
// Adding a UI WebView in Detail View to post event detail data.
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, screenWidth,350)];
    self.myWebView.opaque = NO;
    [self.myWebView setBackgroundColor: [OnSpotUtilities colorWithHexString:@"FBE479"]];
    //self.myWebView.scalesPageToFit = TRUE;
    self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.myWebView.delegate = self;
    [scrollView addSubview:self.myWebView];
    
    
// Adding Event Details in a table and dumping it on the above webView
    NSString *html = [NSString stringWithFormat:@"<html><table border = 1 rules=rows><tr><td width=35%% color=\"white\"><b><i>Event Name</i></b></td><td>%@</td></tr><tr><td><b><i>Venue</i></b></td><td>%@</td></tr><tr><td><b><i>Date & Time</i></b></td><td>%@</td></tr><tr><td><b><i>Website</i></b></td><td>%@</td></tr><tr><td><b><i>Description</i></b></td><td>%@</td></tr></table></html>",detailEventList.eventName,detailEventList.address,[detailEventList formattedDate],detailEventList.website,detailEventList.description];
    [self.myWebView loadHTMLString:html baseURL:detailEventList.websiteURL];
// End Event Details Table
    
//Setting UI Parameters
  // Yellow gradient Bakground
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YellowBG.jpg"]];
  // Blue gradient Bakground
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BlueBG.jpg"]];
    //self.detailDescriptionLabel.textColor = [UIColor whiteColor];
  // Adding event image on the top. This is currently hardcoded. This has to come from JSON.
    UIImageView *eventImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,screenWidth,80)];
    eventImageView.image=[UIImage imageNamed:@"SwaramGoldSpot.jpg"];
    [scrollView addSubview:eventImageView];
    [self configureView];
// End Setting UI Parameters

// Adding Review button programatically
    NSDate * eventDate = [OnSpotUtilities formattedDateTime:detailEventList.dateTime];
    NSDate * currDate = [NSDate date];
    
    UIButton *review= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [review addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [review setFrame:CGRectMake(screenWidth/2-70, 455, 140, 40)];
    [review setTitle:@"Review" forState:UIControlStateNormal];
    [review setExclusiveTouch:TRUE];
    [review setShowsTouchWhenHighlighted:TRUE];
    review.layer.cornerRadius = 1;
    review.layer.borderWidth = 1;
    review.backgroundColor = [OnSpotUtilities colorWithHexString:@"587EAA"]; // Matching the "review" button color
    [review setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if([currDate earlierDate:eventDate] == currDate)
    {
        review.enabled = NO;
        review.userInteractionEnabled = NO;
        review.alpha = 0.5;
    }
    [scrollView addSubview:review];
    scrollView.contentSize = CGSizeMake(screenWidth, 600);
    [self.view addSubview:scrollView];
}

- (void) buttonClicked:(UIButton*)sender
{
    [self performSegueWithIdentifier:@"reviewDetail" sender:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"reviewDetail"])
    {
        [[segue destinationViewController] setReviewEventList:self.detailEventList];
    }
}

@end
