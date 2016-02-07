//
//  SWRevealTailor.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealTailor.h"
#import "UIImage+Color.h"
#import "ButtonFactory.h"
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
    UIButton *button = [ButtonFactory menuButton];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    SWRevealViewController* reveal = (SWRevealViewController*) viewController.revealViewController;
    
    [button addTarget:reveal action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)suitViewControllerUpForNextEvent:(id<RightNextButtonProtocol>)viewController
{
    UIViewController *vc;
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    } else {
        vc = (UIViewController*)viewController;
        UIButton *button = [ButtonFactory nextButton];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        vc.navigationItem.rightBarButtonItem = barButtonItem;
        [button addTarget:vc action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)suitViewControllerUpForFilterEvent:(UIViewController<RightFilterButtonProtocol>*)viewController
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"FILTROS", @"Filtros")
                                                              style:UIBarButtonItemStyleDone
                                                             target:viewController
                                                             action:@selector(showFilters)];
    viewController.navigationItem.rightBarButtonItem = right;
}

- (void)suitViewControllerUpForCancelEvent:(UIViewController<LeftCancelButtonProtocol>*)viewController
{
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CANCEL", @"Cancel")
                                                              style:UIBarButtonItemStyleDone
                                                             target:viewController
                                                             action:@selector(cancel)];
    viewController.navigationItem.leftBarButtonItem = left;
}

#pragma mark - TopicsSelectionDelegate

- (void)viewController:(UIViewController*)viewController
       didSelectTopics:(NSArray *)topics
          withCallback:(SelectedTopicsCallback)callback
{
    BOOL enabled = [topics count] != 0;
    viewController.navigationItem.rightBarButtonItem.enabled = enabled;
    if (callback){ callback(enabled);}
}

@end
