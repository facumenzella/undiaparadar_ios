//
//  FacebookInitializer.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/11/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "FacebookInitializer.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation FacebookInitializer

+ (BOOL)setup:(UIApplication *)application withOptions:(NSDictionary *)launchOptions
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

@end
