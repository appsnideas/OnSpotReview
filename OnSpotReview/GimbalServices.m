//
//  GimbalServices.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 2/5/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "GimbalServices.h"
#import <FYX/FYX.h>
#import <FYX/FYXiBeacon.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>
#import <FYX/FYXSightingManager.h>
#import "EventList.h"
#import "OnSpotUtilities.h"

@interface GimbalServices () <FYXServiceDelegate, FYXiBeaconVisitDelegate, FYXVisitDelegate, UIApplicationDelegate>


@property (nonatomic) FYXVisitManager *visitManager;

@end
@implementation GimbalServices

@synthesize eventListPopUp;

- (void) startService
{
    [FYX startService:self];
}

// *********************    Begin Gimbal Related...   ************************************

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    //NSLog(@"FYX Service Successfully Started");
    
    NSMutableDictionary *options1 = [NSMutableDictionary new];
//    [options1 setObject:[NSNumber numberWithInt:FYXSightingOptionSignalStrengthWindowNone] forKey:FYXSightingOptionSignalStrengthWindowKey];
//    [options1 setObject:[NSNumber numberWithInt:10] forKey:FYXVisitOptionDepartureIntervalInSecondsKey];
//    [options1 setObject:[NSNumber numberWithInt:10] forKey:FYXVisitOptionBackgroundDepartureIntervalInSecondsKey];
//    [options1 setObject:[NSNumber numberWithInt:-60] forKey:FYXVisitOptionArrivalRSSIKey];
//    [options1 setObject:[NSNumber numberWithInt:-70] forKey:FYXVisitOptionDepartureRSSIKey];
    
    self.visitManager = [FYXVisitManager new];
//    self.visitManager.delegate = self;
    self.visitManager.iBeaconDelegate = self;
    [self.visitManager startWithOptions:options1];
    
/*    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:[NSNumber numberWithInt:FYXSightingOptionSignalStrengthWindowNone]
                forKey:FYXSightingOptionSignalStrengthWindowKey];
    
    self.sightingManager = [[FYXSightingManager alloc] init];
    self.sightingManager.delegate = self;
    [self.sightingManager scanWithOptions:options];*/
    
}

- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    //NSLog(@"%@", error);
}

- (void)didArrive:(FYXVisit *)visit;
{
// this will be invoked when an authorized transmitter is sighted for the first time
// Grabbing data from URL
    //NSLog(@"In Did Arrive");
    NSString * eventUrl = [NSString stringWithFormat:@"https://damp-journey-8712.herokuapp.com/osrevents/%@",visit.transmitter.name];
    NSURL *eventsURL = [NSURL URLWithString:eventUrl];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;
    
// Checking if JSON Data is NULL. If NULL currently displaying alert, but have to handle differently later.
    if ([jsonData isEqual:nil] || jsonData == NULL)
    {
        //NSLog(@"No json data");
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                             message:@"No Json Data Found"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Dismiss"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    
// Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSString * eventId = [eventDictionary objectForKey:@"_id"];
    if(!eventId)
        return;
    EventList *eventLists =  [OnSpotUtilities getEventDetails:eventId];
    eventListPopUp = eventLists;
    
// Scheduling a Push Notification. See method below.
    //[OnSpotUtilities scheduleNotificationWithItem: eventLists interval:201 later:FALSE]; //Production
    [OnSpotUtilities scheduleNotificationWithItem: eventLists interval:1 later:FALSE];
}

- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    //NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    //NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}



// ibeacon code
- (void)didArriveIBeacon:(FYXiBeaconVisit *)visit;
{
    // this will be invoked when a managed Gimbal beacon is sighted for the first time
    //NSLog(@"I arrived within the proximity of a Gimbal iBeacon!!! Proximity UUID:%@ Major:%@ Minor:%@ Proximity:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor, visit.iBeacon.proximity);
    
    NSNumber * major = visit.iBeacon.major;
    
    NSArray * nameArray = [visit.iBeacon.uuid componentsSeparatedByString:@"-"];
    if(nameArray.count != 5)
        return;
    NSString *name = [NSMutableString stringWithFormat:@"%@%@%@%@",nameArray[1], nameArray[2], nameArray[3], nameArray[4]];
    //NSLog(@"Name is: %@", name);
    
    
    NSString * eventUrl = [NSString stringWithFormat:@"https://damp-journey-8712.herokuapp.com/osrevents/%@",name];
    NSURL *eventsURL = [NSURL URLWithString:eventUrl];
    NSData *jsonData = [NSData dataWithContentsOfURL:eventsURL];
    NSError *error = nil;
    
    // Checking if JSON Data is NULL. If NULL currently displaying alert, but have to handle differently later.
    if ([jsonData isEqual:nil] || jsonData == NULL)
    {
        //NSLog(@"No json data");
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                             message:@"No Json Data Found"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Dismiss"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    
    // Creating an array of all the posts grabbed from URL and serialized using JSON Searialization.
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSString * eventId = [eventDictionary objectForKey:@"_id"];
    if(!eventId)
        return;
    EventList *eventLists =  [OnSpotUtilities getEventDetails:eventId];
    eventListPopUp = eventLists;
    
    // Scheduling a Push Notification. See method below.
    //[OnSpotUtilities scheduleNotificationWithItem: eventLists interval:201 later:FALSE]; //Production
    [OnSpotUtilities scheduleNotificationWithItem: eventLists interval:major.intValue later:FALSE];
}

/*****************      iBeacon Code.  ******************/
- (void)receivedIBeaconSighting:(FYXiBeaconVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    // this will be invoked when a managed Gimbal beacon is sighted during an on-going visit
    //    NSLog(@"I received a iBeacon sighting!!! Proximity UUID:%@ Major:%@ Minor:%@ %@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor, visit);
}
- (void)didDepartIBeacon:(FYXiBeaconVisit *)visit;
{
    // this will be invoked when a managed Gimbal beacon has not been sighted for some time
    //NSLog(@"I left the proximity of a Gimbal iBeacon!!!! Proximity UUID:%@ Major:%@ Minor:%@", visit.iBeacon.uuid, visit.iBeacon.major, visit.iBeacon.minor);
    //NSLog(@"I was around the iBeacon for %f seconds", visit.dwellTime);
}
/******************************  End Ibeacon code.   *******************/
/*
- (void)didReceiveSighting:(FYXTransmitter *)transmitter time:(NSDate *)time RSSI:(NSNumber *)RSSI
{
    //NSLog(@"in did Receive Sighting");
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    //NSLog(@"in Received Sighting");
}*/

@end
