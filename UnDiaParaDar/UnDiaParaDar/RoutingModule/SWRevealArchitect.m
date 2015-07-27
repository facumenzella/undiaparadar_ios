//
//  SWRevealArchitect.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealArchitect.h"
#import "SWRevealViewController.h"

#import "Director.h"
#import "SWRevealDirector.h"
#import "MenuModuleAssembly.h"
#import "MenuViewController.h"

@interface SWRevealArchitect()

@property (nonatomic, strong) MenuModuleAssembly *menuModuleAssembly;

@end

@implementation SWRevealArchitect

- (instancetype)initWithMenuModuleAssembly:(MenuModuleAssembly*)menuAssembly
{
    if (self = [super init]) {
        self.menuModuleAssembly = menuAssembly;
    }
    return self;
}

- (UIViewController*)buildMainScreenForFlow:(id<Director>)flow withRootViewController:(UIViewController*)vc
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    MenuViewController* menu = [self.menuModuleAssembly menuViewController];
    
    UINavigationController* navigation = [[UINavigationController alloc] init];
    SWRevealViewController* revealVC = [[SWRevealViewController alloc] initWithRearViewController:menu
                                                                              frontViewController:navigation];
    
    
    UIViewController *rootViewController = vc;
    [navigation pushViewController:rootViewController animated:NO];
        
    return revealVC;
}


@end
