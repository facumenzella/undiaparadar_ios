//
//  SWRevealTailor.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealTailor.h"
#import "SWRevealViewController.h"

@implementation SWRevealTailor

- (void)suitViewControllerUpForPrimaryEvent:(UIViewController*)viewController
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
