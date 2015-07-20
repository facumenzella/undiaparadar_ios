//
//  AppDelegate.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "AppDelegate.h"

#import "TyphoonInitializer.h"
#import "Routing.h"

@interface AppDelegate ()

@property (nonatomic, strong) id<Routing> routing;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [TyphoonInitializer setup];
    
    [self.routing showLoginPage];
    
    return YES;
}


@end
