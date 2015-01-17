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

@interface DetailViewController ()

@end

@implementation DetailViewController
- (IBAction)chekIn:(id)sender {
}
- (IBAction)review:(id)sender {
    //ReviewViewController *reviewController = [[ReviewViewController alloc]init];
    //reviewController.testLabel.text = @"Hey Are you there??";
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
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([[segue identifier] isEqualToString:@"reviewDetail"]) {
       MasterViewController *masterController = [[MasterViewController alloc]init];
        ReviewViewController *reviewController = (ReviewViewController *) segue.destinationViewController;
        //MasterViewController *masterController = (MasterViewController *) segue.destinationViewController;
        //EventList *eventLists = [self.eventList1 objectAtIndex:indexPath.row];
        NSIndexPath *indexPath = [masterController.tableView indexPathForSelectedRow];
        reviewController.testLabelText = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        //reviewController.testLabelText= @"Are you there??";
        NSLog(@"Row Selected: %ld",indexPath.row);
     
    
        //NSLog([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
        //ReviewViewController *reviewController = [[ReviewViewController alloc]init];
        //reviewController.testLabelText= @"Are you there??";

    }
    
}

@end
