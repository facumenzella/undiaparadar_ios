//
//  SWRevealTailor.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealTailor.h"

@implementation SWRevealTailor

- (void)prepareViewController:(id)viewController forEvent:(DirectorEvent)event
{
    switch (event) {
        case DirectorEventPrimary:
            
            break;
        case DirectorEventSecondary:
            // You are fine. Just need some confidence VC
            break;
        default:
            NSLog(@"Holy shit the impossible happened");
            break;
    }
}

- (void)suitViewControllerUpForPrimaryEvent:(UIViewController*)viewController
{
    static NSString *sandwichButton = @"nav_bar_icon_menu.png";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 13.5)];
    [button setBackgroundImage:[UIImage imageNamed:sandwichButton] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationItem.leftBarButtonItem = barButtonItem;
}

@end
