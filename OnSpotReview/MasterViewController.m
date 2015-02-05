//
//  MasterViewController.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//


#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ReviewViewController.h"
#import "EventList.h"
#import "OnSpotUtilities.h"


// *********************    Gimbal Related...   *********************************
#import <FYX/FYX.h>
#import <FYX/FYXiBeacon.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>
#import <FYX/FYXSightingManager.h>

@interface MasterViewController () <FYXServiceDelegate, FYXiBeaconVisitDelegate, FYXVisitDelegate, FYXSightingDelegate, UIApplicationDelegate>
@property (nonatomic) FYXVisitManager *visitManager;
@property (nonatomic) FYXSightingManager *sightingManager;
// *********************    Gimbal Related...   *********************************

// non-hardcoded..
@property NSMutableArray *objects;

@end

@implementation MasterViewController

//@synthesize sightingFlag;
@synthesize eventListPopUp;
static NSString *eventId;

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (NSString *) getEventId{
    return eventId;
}

+ (void) setEventId : (NSString *) id
{
    eventId = id;
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
    
    //NSLog(@"1 Here");

    if(jsonData == NULL)
        return;
// Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSArray *eventListArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
   // NSLog(@"2 Here");
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
// Assigning eventLists (EventList object) to a global EventList object (eventListPopUp) so that this can be accessed outside of this method.
        eventListPopUp = eventLists;
    }
   // NSLog(@"3 Here");
    
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
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];

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

// *********************    Begin Gimbal Related...   ************************************

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
    
    self.visitManager = [FYXVisitManager new];
    self.visitManager.delegate = self;
    self.visitManager.iBeaconDelegate = self;
    [self.visitManager start];
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:[NSNumber numberWithInt:FYXSightingOptionSignalStrengthWindowNone]
                forKey:FYXSightingOptionSignalStrengthWindowKey];
    
    self.sightingManager = [[FYXSightingManager alloc] init];
    self.sightingManager.delegate = self;
    [self.sightingManager scanWithOptions:options];
    
}

- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}

/*****************      iBeacon Code. Don't think this is needed.   ******************/

// ibeacon code
- (void)didArriveIBeacon:(FYXiBeaconVisit *)visit;
{
    // this will be invoked when a managed Gimbal beacon is sighted for the first time
    NSLog(@"I arrived within the proximity of a Gimbal iBeacon!!! Proximity UUID:%@ Major:%@ Minor:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor);
}
- (void)receivedIBeaconSighting:(FYXiBeaconVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    // this will be invoked when a managed Gimbal beacon is sighted during an on-going visit
    NSLog(@"I received a iBeacon sighting!!! Proximity UUID:%@ Major:%@ Minor:%@ %@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor, visit);
}
- (void)didDepartIBeacon:(FYXiBeaconVisit *)visit;
{
    // this will be invoked when a managed Gimbal beacon has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal iBeacon!!!! Proximity UUID:%@ Major:%@ Minor:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor);
    NSLog(@"I was around the iBeacon for %f seconds", visit.dwellTime);
}
// End Ibeacon code.

/*****************      iBeacon Code. Don't think this is needed.   ******************/

- (void)didArrive:(FYXVisit *)visit;
{
// this will be invoked when an authorized transmitter is sighted for the first time
// Grabbing data from URL
    NSLog(@"In Did Arrive");
    NSString * eventUrl = [NSString stringWithFormat:@"https://damp-journey-8712.herokuapp.com/osrevents/%@",visit.transmitter.name];
    NSURL *eventsURL = [NSURL URLWithString:eventUrl];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;
    
// Checking if JSON Data is NULL. If NULL currently displaying alert, but have to handle differently later.
    if ([jsonData isEqual:nil] || jsonData == NULL)
    {
        NSLog(@"No json data");
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"No Jason Data Found"
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    
// Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    //self.eventList1 = [NSMutableArray array];
    EventList *eventLists = [EventList eventListWithName:[eventDictionary objectForKey:@"name"]];
 
// Gathering EventId and Time of the Event
    NSString *eventTime = [[NSString alloc]init];
    if (![eventDictionary objectForKey:@"_Id"])
    {
        eventLists.eventId = [eventDictionary objectForKey:@"_id"];
    }
    if ([eventDictionary objectForKey:@"eventDateAndTime"] != NULL)
    {
        eventLists.dateTime = [eventDictionary objectForKey:@"eventDateAndTime"];
        eventTime = [NSString stringWithFormat:@"Date: %@",[eventLists formattedDate]];
        NSLog(@"Event Date and Time: %@",eventTime);
    }
    NSLog(@"Event Id: %@", eventLists.eventId);
    
//Populating data dictionary for review questions.
    NSString *reviewQuestionId = [eventDictionary valueForKeyPath:@"reviewquestions.id"];
    NSString *reviewQuestion = [eventDictionary valueForKeyPath:@"reviewquestions.question"];
    eventLists.reviewQuestions = [NSDictionary dictionaryWithObjectsAndKeys:reviewQuestion, reviewQuestionId, nil];
    //[self.eventList1 addObject:eventLists];
    eventListPopUp = eventLists;

// Scheduling a Push Notification. See method below.
    [self scheduleNotificationWithItem: eventLists interval:1];
}

- (void)didReceiveSighting:(FYXTransmitter *)transmitter time:(NSDate *)time RSSI:(NSNumber *)RSSI
{
    //NSLog(@"in did Receive Sighting");
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    //NSLog(@"in Received Sighting");
}

- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}

- (void)scheduleNotificationWithItem:(EventList *)item interval:(int)minutesBefore {
    NSDate *itemDate = [OnSpotUtilities formattedDateTime:item.dateTime];
    NSLog(@"in scheduleNotificationWithItem - begin");
    
/***********************************************************/
// Interactive Notifications Alert - Registering an Action
    NSLog(@"Event Date and Time schedule: %@",itemDate);
    UIMutableUserNotificationAction *review = [[UIMutableUserNotificationAction alloc] init];
    UIMutableUserNotificationAction *later = [[UIMutableUserNotificationAction alloc] init];
    review.identifier = @"REVIEW_ID";//item.eventId; // The id passed when the user selects the action
    later.identifier = @"LATER_ID";//item.eventId;
    review.title = NSLocalizedString(@"Sure!..",nil);
    later.title = NSLocalizedString(@"Later",nil);
    review.activationMode = UIUserNotificationActivationModeForeground;
    later.activationMode = UIUserNotificationActivationModeBackground;
    review.destructive = NO; // If YES, then the action is red
    later.destructive = NO;
    review.authenticationRequired = YES;
    later.authenticationRequired = NO;// Whether the user must authenticate to execute the action
    
// Interactive Notifications Category - Creating a Category of Actions
    UIMutableUserNotificationCategory *firstResponse = [[UIMutableUserNotificationCategory alloc] init];
    firstResponse.identifier = @"REVIEW_CATEGORY"; // Identifier passed in the payload
    //[firstResponse setActions:@[review, later] forContext:UIUserNotificationActionContextDefault];
    [firstResponse setActions:@[review, later] forContext:UIUserNotificationActionContextMinimal];
    
// Registering Categories
    NSSet *categories = [NSSet setWithObjects:firstResponse, nil];
    NSUInteger types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound; // Add badge, sound, or alerts here
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
// Local Notifications
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.category = @"REVIEW_CATEGORY";
    [localNotif setUserInfo:@{eventListPopUp.eventId : @"identifier"}];
    //[localNotif setUserInfo:@{eventListPopUp.eventId : eventListPopUp}];
    localNotif.fireDate = [itemDate dateByAddingTimeInterval:-(minutesBefore*60)];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ would love to get your feedback for the event.", nil),item.eventName];
    //localNotif.alertAction = NSLocalizedString(@"Yes", nil);
    //localNotif. = NSLocalizedString(@"Event Review", nil);
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    //localNotif.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    eventId = eventListPopUp.eventId;
    NSLog(@"in scheduleNotificationWithItem - end");
}

+ (EventList *) getEventDetails:(NSString *)eventId
{
    // Grabbing data from URL
    NSString * eventUrl = [NSString stringWithFormat:@"https://damp-journey-8712.herokuapp.com/osrevents/%@",eventId];
    NSURL *eventsURL = [NSURL URLWithString:eventUrl];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;
    
    // Checking if JSON Data is null
    if ([jsonData isEqual:nil] || jsonData == NULL) {
        NSLog(@"No json data");
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                             message:@"No Jason Data Found"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Dismiss"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        return NULL;
    }
    
    // Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    //self.eventList1 = [NSMutableArray array];
    EventList *eventLists = [EventList eventListWithName:[eventDictionary objectForKey:@"name"]];
    
    // Gathering EventId and Time of the Event
    NSString *eventTime = [[NSString alloc]init];
    if (![eventDictionary objectForKey:@"_Id"])
    {
        eventLists.eventId = [eventDictionary objectForKey:@"_id"];
    }
    if ([eventDictionary objectForKey:@"eventDateAndTime"] != NULL)
    {
        eventLists.dateTime = [eventDictionary objectForKey:@"eventDateAndTime"];
        eventTime = [NSString stringWithFormat:@"Date: %@",[eventLists formattedDate]];
        NSLog(@"Event Date and Time: %@",eventTime);
    }
    NSLog(@"Event Id: %@", eventLists.eventId);
    
    //Populating data dictionary for review questions.
    NSString *reviewQuestionId = [eventDictionary valueForKeyPath:@"reviewquestions.id"];
    NSString *reviewQuestion = [eventDictionary valueForKeyPath:@"reviewquestions.question"];
    eventLists.reviewQuestions = [NSDictionary dictionaryWithObjectsAndKeys:reviewQuestion, reviewQuestionId, nil];
    return eventLists;
}

// *********************    End Gimbal Related...   *********************************

@end