//
//  MasterViewController.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//


#import "MasterViewController.h"
#import "DetailViewController.h"
#import "EventList.h"
// *********************    Gimbal Related...   *********************************
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>

@interface MasterViewController () <FYXServiceDelegate, FYXVisitDelegate>
@property (nonatomic) FYXVisitManager *visitManager;
// *********************    Gimbal Related...   *********************************

//@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
// *********************    Gimbal Related... Starting FYX Service  *********************************
    
    [FYX startService:self];
    
// *********************    Gimbal Related...   *****************************************************
    
// *********************************************        App Code   **********************************************************
    
     // Hardcoded Data dictionary
     NSDictionary *swaramEvent1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 1",@"title",@"Feb 7th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 2",@"title",@"Feb 7th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent3 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 3",@"title",@"Feb 8th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent4 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 4",@"title",@"Feb 14th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent5 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Telugu Drama 1",@"title",@"Feb 8th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent6 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Telugu Drama 2",@"title",@"Feb 14th 2015",@"date",@"Saratoga, CA",@"place",nil];
    
     self.eventList = [NSArray arrayWithObjects:swaramEvent1,swaramEvent2,swaramEvent3,swaramEvent4,swaramEvent5,swaramEvent6,nil];

// ************************    Default Code    **************************************
    
     // Do any additional setup after loading the view, typically from a nib.
     
     //self.navigationItem.leftBarButtonItem = self.editButtonItem;
     
     //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
     //    self.navigationItem.rightBarButtonItem = addButton;*/
// ************************    Default Code    **************************************
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ************************    Default Code    **************************************

/*
 - (void)insertNewObject:(id)sender {
 if (!self.objects) {
 self.objects = [[NSMutableArray alloc] init];
 }
 [self.objects insertObject:[NSDate date] atIndex:0];
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
 [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
 }
 */
// ************************    Default Code    **************************************

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     _detailList = @[@"Gold Spot\nSwaram Tamil Drama\nSaturday Feb 7th\nTime: 1:00 PM\nVenue: West Valley College Theatre\n14000 Fruitvale Avenue\nSaratoga, CA 95070\nFor more information: www.swaram.org",
     @"Gold Spot\nSwaram Tamil Drama\nSaturday Feb 7th\nTime: 5:30 PM\nVenue: West Valley College Theatre\n14000 Fruitvale Avenue\nSaratoga, CA 95070\nFor more information: www.swaram.org",
     @"Gold Spot\nSwaram Tamil Drama\nSunday Feb 8th\nTime: 5:30 PM\nVenue: West Valley College Theatre\n14000 Fruitvale Avenue\nSaratoga, CA 95070\nFor more information: www.swaram.org",
     @"Gold Spot\nSwaram Tamil Drama 4\nSatday Feb 14th\nTime: 1:00 PM\nVenue: West Valley College Theatre\n14000 Fruitvale Avenue\nSaratoga, CA 95070\nFor more information: www.swaram.org",
     @"Gold Spot\nSwaram Telugu Drama 1\nSunday Feb 8th\nTime: 1:00 PM\nVenue: West Valley College Theatre\n14000 Fruitvale Avenue\nSaratoga, CA 95070\nFor more information: www.swaram.org",
     @"Gold Spot\nSwaram Telugu Drama 2\nSaturday Feb 14th\nTime: 5:30 PM\nVenue: West Valley College Theatre\n14000 Fruitvale Avenue\nSaratoga, CA 95070\nFor more information:www.swaram.org"];
     
     if ([[segue identifier] isEqualToString:@"showDetail"]) {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     //NSString *eventTitle = self.eventList[indexPath.row];
     //[[segue destinationViewController] setDetailItem:eventTitle];
     [[segue destinationViewController] setDetailItem:self.detailList[indexPath.row]];
     
     }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventList.count;    // App Code
    //return self.eventList1.count; // Test code
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *eventRow = [self.eventList objectAtIndex:indexPath.row];
     cell.textLabel.text = [eventRow valueForKey:@"title"];
     cell.detailTextLabel.text = [NSString stringWithFormat:@"Venue: %@ Date: %@", [eventRow valueForKey:@"place"], [eventRow valueForKey:@"date"]];
    
// Can be utilized for Web JSON data
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"Venue: %@ Date: %@", eventLists.author, eventLists.date];
    
// Beautify the cells by adding color and alternating.
    static NSString *cellIdentifier = @"DefaultCell";
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row % 2) {
        UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.15];
        cell.backgroundColor = altCellColor;
    }
// end beauify
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
// *********************************************        App Code   **********************************************************

// ************************    Default Code    **************************************
/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 [self.objects removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }
 }
 */

/* This is actually not needed in a Master-Detail set up. This is more for Single View Controller with another view controller created by user. The equivalent of this in Master- Detail is "prepareForSegue" method. Commenting out this method.
 
 #pragma mark - Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here. Create and push another view controller.
 DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
 // ..
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 
 }
 */
/*
 #pragma mark - Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here. Create and push another view controller.
 DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
 // ..
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 
 }
 */
// ************************    Default Code    **************************************


// *********************    Gimbal Related...   ************************************

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
    
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    [self.visitManager start];
}

- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}

- (void)didArrive:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter is sighted for the first time
    NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}
- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
}
- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

// *********************    Gimbal Related...   *********************************

@end
