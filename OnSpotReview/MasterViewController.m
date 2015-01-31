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
#import "OnSpotUtilities.h"

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
    
//Yellow Gradient
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YellowBG.jpg"]]];
    
//Blue Gradient
    //[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlueBG.jpg"]]];
    
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
        
        if ([eventDictionary objectForKey:@"address"] != NULL)
        {
            eventLists.address = [eventDictionary objectForKey:@"address"];
        }
        
        if ([eventDictionary objectForKey:@"description"] != NULL)
        {
            eventLists.description = [eventDictionary objectForKey:@"description"];
        }
        
        if ([eventDictionary objectForKey:@"eventDateAndTime"] != NULL)
        {
            eventLists.dateTime = [eventDictionary objectForKey:@"eventDateAndTime"];
        }
        
        if ([eventDictionary objectForKey:@"_id"] != NULL)
        {
             eventLists.eventId = [eventDictionary objectForKey:@"_id"];
        }
        
        if ([eventDictionary objectForKey:@"website"] != NULL)
        {
            eventLists.website = [eventDictionary objectForKey:@"website"];
        }
        
        if ([eventDictionary objectForKey:@"ticketingurl"] != NULL)
        {
            eventLists.ticketingURL = [eventDictionary valueForKeyPath:@"ticketingurl.ticketingurl"];
        }
        
//Populating data dictionary for review questions.
        NSString *reviewQuestionId = [eventDictionary valueForKeyPath:@"reviewquestions.id"];
        NSString *reviewQuestion = [eventDictionary valueForKeyPath:@"reviewquestions.question"];
        eventLists.reviewQuestions = [NSDictionary dictionaryWithObjectsAndKeys:reviewQuestion,reviewQuestionId, nil];
        [self.eventList1 addObject:eventLists];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EventList *eventLists = [self.eventList1 objectAtIndex:indexPath.row];
    // Passing eventLists EventList Object to Detail View controller
        [[segue destinationViewController] setDetailEventList:eventLists];
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
    
// Beautify the cells by adding color and alternating.
    cell.textLabel.textColor = [UIColor brownColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];
    cell.detailTextLabel.shadowColor = [UIColor blackColor];
    cell.detailTextLabel.shadowOffset = CGSizeMake(0,0);
    static NSString *cellIdentifier = @"DefaultCell";
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row % 2)
    {
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
    // Grabbing data from URL
    NSURL *eventsURL = [NSURL URLWithString:@"https://damp-journey-8712.herokuapp.com/osrevents/54ba0e697ae8c6090051e9b0"];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;
    
    // Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    // instantiating 'Mutable Array declared in .h. Why Mutable - coz we are adding elements dynamically and do not know the capcity.
    self.eventList1 = [NSMutableArray array];
    
    // Loop thru the array to parse and store the data into our custom class.
    // Here we instantiate an object (eventLists) of our custom class, 'EventList' and add data into its properties (Declared variables).
    // NOTE: The ending parts (@title, @author etc..are keys from URL, not our variables
    
    //for (NSDictionary *eventDictionary in eventListArray)
    //{
        EventList *eventLists = [EventList eventListWithName:[eventDictionary objectForKey:@"name"]];
        
        if ([eventDictionary objectForKey:@"address"] == NULL)
        {
            eventLists.address = NULL;
        }
        else
        {
            eventLists.address = [eventDictionary objectForKey:@"address"];
        }
        
        if ([eventDictionary objectForKey:@"description"] == NULL)
        {
            eventLists.description = NULL;
        }
        else
        {
            eventLists.description = [eventDictionary objectForKey:@"description"];
        }
        
        if ([eventDictionary objectForKey:@"eventDateAndTime"] == NULL)
        {
            eventLists.dateTime = NULL;
        }
        else
        {
            eventLists.dateTime = [eventDictionary objectForKey:@"eventDateAndTime"];
        }
        
        if ([eventDictionary objectForKey:@"_id"] == NULL)
        {
            eventLists.eventId = NULL;
        }
        else
        {
            eventLists.eventId = [eventDictionary objectForKey:@"_id"];
        }
        
        if ([eventDictionary objectForKey:@"website"] == NULL)
        {
            eventLists.website = NULL;
        }
        else
        {
            eventLists.website = [eventDictionary objectForKey:@"website"];
        }
        
        if ([eventDictionary objectForKey:@"ticketingurl"] == NULL)
        {
            eventLists.ticketingURL = NULL;
        }
        else
        {
            eventLists.ticketingURL = [eventDictionary valueForKeyPath:@"ticketingurl.ticketingurl"];
        }
        
        //Populating data dictionary for review questions.
        NSString *reviewQuestionId = [eventDictionary valueForKeyPath:@"reviewquestions.id"];
        NSString *reviewQuestion = [eventDictionary valueForKeyPath:@"reviewquestions.question"];
        eventLists.reviewQuestions = [NSDictionary dictionaryWithObjectsAndKeys:reviewQuestion, reviewQuestionId, nil];
        
        // What exactly does this statement do??
        [self.eventList1 addObject:eventLists];
    NSLog(@"In Gimbal didArrive");
   // }

    NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}
- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    //NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
}
- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

// *********************    Gimbal Related...   *********************************

@end