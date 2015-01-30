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
/*
- (void)setDetailItem:(id)newDetailItem
{
    
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
       // [self configureView];
    }
}
*/
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

// Adding a UI WebView in Detail View to post event detail data.
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, 320,350)];
    self.myWebView.opaque = NO;
    self.myWebView.backgroundColor = [UIColor clearColor];
    //self.myWebView.scalesPageToFit = YES;
    //self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
    
// Adding Event Details in a table and dumping it on the above webView
    NSString *html = [NSString stringWithFormat:@"<html><table border = 1 rules=rows><tr><td width=35%% color=\"white\"><b><i>Event Name</i></b></td><td>%@</td></tr><tr><td><b><i>Venue</i></b></td><td>%@</td></tr><tr><td><b><i>Date & Time</i></b></td><td>%@</td></tr><tr><td><b><i>Website</i></b></td><td>%@</td></tr><tr><td><b><i>Description</i></b></td><td>%@</td></tr></table></html>",detailEventList.eventName,detailEventList.address,[detailEventList formattedDate],detailEventList.website,detailEventList.description];
    [self.myWebView loadHTMLString:html baseURL:detailEventList.websiteURL];
// End Event Details Table
    
//Setting UI Parameters
  // Yellow gradient Bakground
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YellowBG.jpg"]];
  // Blue gradient Bakground
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BlueBG.jpg"]];
    self.detailDescriptionLabel.textColor = [UIColor whiteColor];
  // Adding event image on the top. This is currently hardcoded. This has to come from JSON.
    UIImageView *eventImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,80)];
    eventImageView.image=[UIImage imageNamed:@"SwaramGoldSpot.jpg"];
    [self.view addSubview:eventImageView];
    [self configureView];
// End SAetting UI Parameters
    
}

- (void) buttonClicked:(UIButton*)sender
{
    
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
