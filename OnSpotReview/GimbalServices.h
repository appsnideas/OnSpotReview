//
//  GimbalServices.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 2/5/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventList.h"

@interface GimbalServices : NSObject

@property (strong, nonatomic) EventList * eventListPopUp;

- (void) startService;
@end
