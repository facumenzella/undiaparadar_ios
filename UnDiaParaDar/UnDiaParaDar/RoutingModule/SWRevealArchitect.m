//
//  SWRevealArchitect.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealArchitect.h"
#import "SWRevealViewController.h"

#import "Tailor.h"
#import "SWRevealDirector.h"
#import "MenuModuleAssembly.h"
#import "MenuViewController.h"

@interface SWRevealArchitect()

@property (nonatomic, strong) MenuModuleAssembly *menuModuleAssembly;
@property (nonatomic, strong) id<Tailor> tailor;

@end

@implementation SWRevealArchitect

- (instancetype)initWithMenuModuleAssembly:(MenuModuleAssembly*)menuAssembly withTailor:(id<Tailor>)tailor
{
    if (self = [super init]) {
        self.menuModuleAssembly = menuAssembly;
        self.tailor = tailor;
    }
    return self;
}

- (UIViewController*)buildMainScreenWithRootViewController:(UIViewController*)vc
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    MenuViewController* menu = [self.menuModuleAssembly menuViewController];
    
    UINavigationController* navigation = [[UINavigationController alloc] init];
    SWRevealViewController* revealVC = [[SWRevealViewController alloc] initWithRearViewController:menu
                                                                              frontViewController:navigation];
    
    UIViewController *rootViewController = vc;
    [navigation pushViewController:rootViewController animated:NO];
    [self.tailor suitViewControllerUpForMenuEvent:rootViewController];
    
    return revealVC;
}


@end
