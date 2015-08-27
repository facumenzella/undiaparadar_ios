//
//  SWRevealTailor.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealTailor.h"
#import "UIImage+Color.h"
#import "SWRevealViewController.h"

static UIImage *TAILOR_NAV_BAR_IMAGE;

@implementation SWRevealTailor

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildNavBarImage];
        [[UINavigationBar appearance] setBackgroundImage:TAILOR_NAV_BAR_IMAGE
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"color_band"]];
    }
    return self;
}

- (void)buildNavBarImage
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        TAILOR_NAV_BAR_IMAGE = [UIImage imageWithColor:[UIColor whiteColor]];
        });
}

- (void)suitViewControllerUpForMenuEvent:(UIViewController*)viewController
{
    static NSString *sandwichButton = @"nav_bar_icon_menu.png";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 13.5)];
    [button setBackgroundImage:[UIImage imageNamed:sandwichButton] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    SWRevealViewController* reveal = (SWRevealViewController*) viewController.revealViewController;
    
    [button addTarget:reveal action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = barButtonItem;
}

@end
