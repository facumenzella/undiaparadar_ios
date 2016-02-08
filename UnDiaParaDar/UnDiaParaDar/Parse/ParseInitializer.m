//
//  ParseInitializer.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ParseInitializer.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

@implementation ParseInitializer

+ (void)setupWithLaunchOptions:(NSDictionary*)launchOptions
{
    [Parse setApplicationId:@"EQYn0fafGF0NFi7IyZDBzBUKWcewFKI6SsiMUIe8"
                  clientKey:@"9nii0zRFoSxyzyspa1bqihXzdbaYAF561twEbB2j"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
}

@end
