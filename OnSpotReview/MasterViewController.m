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

@property NSMutableArray *objects;
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
    
    // ***************      Test code from class        *********************************************************************
    
    // Grabbing data from URL
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    //NSLog(@"%@", jsonData);
    NSError *error = nil;
    
    // Creating a data dictionary for all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    // instantiating 'Mutable Array declared in .h. Why Mutable - coz we are adding elements dynamically and do not know the capcity.
    self. eventList1 = [NSMutableArray array];
    
    // Creating an array to hold all the posts from the data dictionary of posts from above. This is basically an array of post dictionaries
    NSArray *eventListArray = [dataDictionary objectForKey:@"posts"];
    
    // Loop thru the array of dictionaries to parse and store the data into our custom class.
    for (NSDictionary *eventDictionary in eventListArray) {
        
        // Here we instantiate (as in learning code) an object of our custom class 'EventList and add data into its properties.
        // NOTE: The ending parts (@title, @author etc..are keys from URL, not our variables
        EventList *eventLists = [EventList eventListWithTitle:[eventDictionary objectForKey:@"title"]];
        eventLists.author = [eventDictionary objectForKey:@"author"];
        eventLists.thumbnail = [eventDictionary objectForKey:@"thumbnail"];
        eventLists.date = [eventDictionary objectForKey:@"date"];
        // Blog JSON's URL is a string. We need something that we can click on it and open it in a browser, which is type NSURL. So,We need
        // to convert the JSON URL 'String' to NSURL Type (Our url property in custom class is also NSURL type) and hence the below line of
        // code.
        eventLists.URL = [NSURL URLWithString:[eventDictionary objectForKey:@"url"]];
        [self.eventList1 addObject:eventLists];
    }
    
    // ********************* This code is not needed. Only for learning.    *******************
    //self.eventList = [dataDictionary objectForKey:@"posts"];
    
    // Instantiation of the custom class EventList class declared in EventList.h and Accessing and setting instance variables from EventList class via properties
    //EventList *eventList1 = [[EventList alloc] init];
    //  eventList1.title = @"Nice Title";
    
    // The above title instantiation is not needed as we are using the designated instantiator below..
    
    // Accessing and setting instance variables from EventList class via getter and setter methods
    /* eventList1.title = @"Some title"; //or  [eventList1 setTitle:@"Some String"];
     NSString *string = eventList1.title; //or NSString *string1 = [eventList1 title]; */
    
    // Instantiating the custom class using 'designated instantiator' and accessing other variable via properties.
    /* EventList *eventList1 = [[EventList alloc] initWithTitle:@"Nice Title"]; // initializing the tile
     eventList1.author = @"Vamsi Nadella";
     
     // Instantiating the custom class using 'convienience constructor' and accessing other variable via properties.
     // The difference between designated initializor and convienience constructor is, the latter allocates and instaniates in one statement.
     EventList *eventList1 = [EventList eventListWithTitle:@"Nice Title Tooo!!"];
     eventList1.author = @"Vamsi K Nadella";*/
    // ********************* This code is not needed. Only for learning.    *******************
    
    // ***************      Test code from class        ********************************************************************
    
    // *********************    App Code   *********************************
    /*
     // Hardcoded Data dictionary
     NSDictionary *swaramEvent1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 1",@"title",@"Feb 7th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 2",@"title",@"Feb 7th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent3 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 3",@"title",@"Feb 8th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent4 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Tamil Drama 4",@"title",@"Feb 14th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent5 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Telugu Drama 1",@"title",@"Feb 8th 2015",@"date",@"Saratoga, CA",@"place",nil];
     NSDictionary *swaramEvent6 = [NSDictionary dictionaryWithObjectsAndKeys:@"Swaram Telugu Drama 2",@"title",@"Feb 14th 2015",@"date",@"Saratoga, CA",@"place",nil];
     
     // grabbing data from db using API/URL
     //self.eventList = [dataDictionary objectForKey:@"posts"]; - This may or may not be needed.
     // NSURL *eventURL = [NSURL URLWithString:@"<<URL>>"];
     // NSData *jsonData = [NSData dataWithContentsOfURL:eventURL];
     // NSLog(@"%@", jsonData);
     // NSError *error = nil;
     
     NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
     self.eventList = [NSArray arrayWithObjects:swaramEvent1,swaramEvent2,swaramEvent3,swaramEvent4,swaramEvent5,swaramEvent6, nil];
     
     // Do any additional setup after loading the view, typically from a nib.
     
     //self.navigationItem.leftBarButtonItem = self.editButtonItem;
     
     //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
     //    self.navigationItem.rightBarButtonItem = addButton;*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //  ******************************  Test Code    **************************
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        // Opening a web page using the URL.
        EventList *eventLists = [self.eventList1 objectAtIndex:indexPath.row];
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:eventLists.URL];
        
        //NSString *eventTitle = self.eventList[indexPath.row];
        //[[segue destinationViewController] setDetailItem:eventTitle];
        [[segue destinationViewController] setDetailItem:self.detailList[indexPath.row]];
        //NSLog(@"Row Selected: %ld",indexPath.row);
        
    }
    
    //  ******************************  Test Code    **************************
    /*
     //  ******************************  App Code    **************************
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
     //  ******************************  App Code    **************************
     */
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.eventList.count;
    return self.eventList1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //         ******** App Code *************
    /*NSDictionary *eventRow = [self.eventList objectAtIndex:indexPath.row];
     cell.textLabel.text = [eventRow valueForKey:@"title"];
     cell.detailTextLabel.text = [eventRow valueForKey:@"date"]; - This is for app code..*/
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ Date: %@", eventLists.author, eventLists.date];
    //         ******** App Code *************
    
    //         ******** Test Code *************
    EventList *eventLists = [self.eventList1 objectAtIndex:indexPath.row];
    // NSLog(@"%@", eventLists.thumbnail);
    
    if ( [eventLists.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:eventLists.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    } else{
        cell.imageView.image = [UIImage imageNamed:@"ReviewIcon2.jpeg"];
    }
    
    cell.textLabel.text = eventLists.title;
    //cell.detailTextLabel.text = eventLists.author;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ Date: %@", eventLists.author, [eventLists formattedDate]];
    //         ******** Test Code *************
    
    // Beautify the cells by adding color and alternating.
    static NSString *cellIdentifier = @"DefaultCell";
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    /* if (indexPath.row % 2) {
     cell.backgroundColor = [UIColor blueColor];
     }else {
     cell.backgroundColor = [UIColor greenColor];
     }*/
    if (indexPath.row % 2) {
        UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.15];
        cell.backgroundColor = altCellColor;
    }
    // end beauify
    
    return cell;
}

//    NSString *object = self.eventList[indexPath.row];
//    cell.textLabel.text = object;
//    return cell;


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
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
// *********************    App Code..   *********************************

// *********************    Gimbal Related...   *********************************

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
