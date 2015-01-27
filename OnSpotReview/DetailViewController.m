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

- (IBAction)chekIn:(id)sender {
}
- (IBAction)review:(id)sender {
    
    
    
    }

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {

// Setting the background
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"vAGZ.jpg"]];
    
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//Setting back ground color as our image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"vAGZp.jpg"]];
    self.detailDescriptionLabel.textColor = [UIColor blackColor];
    //self.detailDescriptionLabel.font = UIfon
// Adding event image on the top. This is currently hardcoded. This has to come from JSON.
    UIImageView *eventImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,60,320,80)];
    eventImageView.image=[UIImage imageNamed:@"SwaramGoldSpot.jpg"];
    [self.view addSubview:eventImageView];
    [self configureView];
// Here we have to check if we can add a textview instead of label.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
