//
//  OnSpotUtilities.h
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/26/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface OnSpotUtilities : NSObject

+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (void)setMasterBGColor:(UITableViewController *)masterController;
+ (void)setBGColor: (UIViewController *)viewController;

@end
