//
//  AppDelegate.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/9/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContextCore/QLContextCoreConnector.h>
#import "GimbalServices.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) QLContextCoreConnector *connector;
@property (strong, nonatomic) GimbalServices * gimbalServices;

@end

