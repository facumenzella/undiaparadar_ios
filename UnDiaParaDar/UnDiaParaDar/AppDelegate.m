//
//  AppDelegate.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "AppDelegate.h"

#import "BeautyCenter.h"
#import "TyphoonInitializer.h"
#import "FacebookInitializer.h"
#import "NetworkReachabilityController.h"

#import "Routing.h"
#import "LocationManager.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) NetworkReachabilityController *networkReachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    BOOL fbSetup = [FacebookInitializer setup:application withOptions:launchOptions];
    [TyphoonInitializer setup];
    [BeautyCenter setup];
    [LocationManager sharedInstance];
    [self setupNetwork];
    
    [self.routing showSplash];
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"User already logged in");
        [self landingPage];
        return fbSetup;
    }
    return fbSetup;
}

- (void) landingPage
{
    [self.routing showMainPage];
}

- (void) loginPage
{
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self.routing
                                   selector:@selector(showLoginPage)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)setupNetwork
{
    [self.networkReachability setup];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

@end
