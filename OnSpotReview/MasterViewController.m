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

// non-hardcoded..
@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
// *********************    Gimbal Related... Starting FYX Service  *********************************
    
    [FYX startService:self];
    
// *********************    Gimbal Related...   *****************************************************

// Setting the background
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vAGZp.jpg"]]];

// Grabbing data from URL
    NSURL *eventsURL = [NSURL URLWithString:@"https://damp-journey-8712.herokuapp.com/osrevents"];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;

// Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSArray *eventListArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
// instantiating 'Mutable Array declared in .h. Why Mutable - coz we are adding elements dynamically and do not know the capcity.
    self.eventList1 = [NSMutableArray array];
    
// Loop thru the array to parse and store the data into our custom class.
// Here we instantiate an object (eventLists) of our custom class, 'EventList' and add data into its properties (Declared variables).
// NOTE: The ending parts (@title, @author etc..are keys from URL, not our variables

    for (NSDictionary *eventDictionary in eventListArray)
    {
        EventList *eventLists = [EventList eventListWithName:[eventDictionary objectForKey:@"name"]];
        
        if ([eventDictionary objectForKey:@"address"] == NULL){
            eventLists.address = NULL;
        }
        else {
            eventLists.address = [eventDictionary objectForKey:@"address"];
        }
        if ([eventDictionary objectForKey:@"description"] == NULL){
            eventLists.description = NULL;
        }
        else {
            eventLists.description = [eventDictionary objectForKey:@"description"];
        }
        if ([eventDictionary objectForKey:@"eventDateAndTime"] == NULL){
            eventLists.dateTime = NULL;
        }
        else {
            eventLists.dateTime = [eventDictionary objectForKey:@"eventDateAndTime"];
        }
// There are 3 "_Ids" in the JSON, have to figure out how to differentiate these.
        if ([eventDictionary objectForKey:@"_id"] == NULL){
         eventLists.eventId = nil;
         }
         else {
         eventLists.eventId = [eventDictionary objectForKey:@"_id"];
         }
// JSON's URLs are strings. We need something that we can click on it and open it in a browser, which is type NSURL. So,We need
// to convert the JSON URL 'String' to NSURL Type and hence the below lines of code.
        
        if ([eventDictionary objectForKey:@"website"] == NULL){
            eventLists.website = NULL;
        }
        else {
            //eventLists.website = [NSURL URLWithString:[eventDictionary objectForKey:@"website"]];
            eventLists.website = [eventDictionary objectForKey:@"website"];
        }
// We need to handle null strings (converted to null NSURL object). Will take care of this later.
        /*  if ([eventDictionary objectForKey:@"ticketingurl"] == NULL){
            eventLists.ticketingURL = Nil;
        }
        else
            eventLists.ticketingURL = [NSURL URLWithString:[eventDictionary objectForKey:@"ticketingurl"]];
            NSLog(@"In ticket else");
        }*/

// What exactly does this statement do??
        [self.eventList1 addObject:eventLists];
        //NSLog(@"Id: %@", eventLists.eventId);
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EventList *eventLists = [self.eventList1 objectAtIndex:indexPath.row];
        NSString *detailLabelText = [NSString stringWithFormat:@"Event Name: %@\nVenue: %@\nDate & Time: %@\nWebsite: %@\n\nDescription: %@", eventLists.eventName,eventLists.address,[eventLists formattedDate],eventLists.website, eventLists.description];
        [[segue destinationViewController] setDetailItem:detailLabelText];        
// Opening a web page using the URL.
        //UIApplication *application = [UIApplication sharedApplication];
        //[application openURL:eventLists.website];

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.eventList1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    EventList *eventLists = [self.eventList1 objectAtIndex:indexPath.row];
    cell.textLabel.text = eventLists.eventName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Date: %@",[eventLists formattedDate]];
   /*
// If we need to create a image URL then we need the following code.
    if ( [eventLists.thumbnail isKindOfClass:[NSString class]]) {
     //NSData *imageData = [NSData dataWithContentsOfURL:eventLists.thumbnailURL];
        NSData *imageData = [NSData dataWithContentsOfFile:@"/Users/vamsi/Apps/OnSpotReview/images/Swaram_Small.jpg"];
     UIImage *image = [UIImage imageWithData:imageData];
     cell.imageView.image = image;
     } else{
     cell.imageView.image = [UIImage imageNamed:@"ReviewIcon2.jpeg"];
     }*/
    
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

// ************************    Default Code    **************************************
/*
 
// This code is from viewDidLoad Method. Just FYI

 //Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;

// This code is from viewDidLoad Method. Just FYI
 
 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 - (void)insertNewObject:(id)sender {
 if (!self.objects) {
 self.objects = [[NSMutableArray alloc] init];
 }
 [self.objects insertObject:[NSDate date] atIndex:0];
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
 [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
 }
 

 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 [self.objects removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }
 }

 //This is actually not needed in a Master-Detail set up. This is more for Single View Controller with another view controller created by user. The equivalent of this in Master- Detail is "prepareForSegue" method. Commenting out this method.
 
 #pragma mark - Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here. Create and push another view controller.
 DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
 // ..
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 
 }

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
