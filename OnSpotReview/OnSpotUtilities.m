//
//  OnSpotUtilities.m
//  OnSpotReview
//
//  Created by Vamsikrishna Nadella on 1/26/15.
//  Copyright (c) 2015 appsnideas. All rights reserved.
//

#import "OnSpotUtilities.h"

@implementation OnSpotUtilities

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(void) setMasterBGColor:(UITableViewController *)masterController;{
    
    [masterController.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YellowBG.jpg"]]];
    
}

+(void) setBGColor:(UIViewController *)viewController;{
    
    viewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YellowBG.jpg"]];
    
}


@end