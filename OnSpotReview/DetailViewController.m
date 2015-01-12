//
//  DetailViewController.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
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
        [self configureView];
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
    
    //[self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
