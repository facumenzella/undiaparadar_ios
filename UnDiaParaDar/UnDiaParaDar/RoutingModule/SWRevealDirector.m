//
//  SWRevealDirector.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealDirector.h"
#import "SWRevealViewController.h"

@interface SWRevealDirector ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation SWRevealDirector

#pragma mark - SWRevealDirector

- (instancetype) initWithWindow:(UIWindow*)window
{
    if (self = [super init]) {
        self.window = window;
    }
    return self;
}

- (void)setRoot:(UIViewController *)vc
{
    assert(vc);
    self.window.rootViewController = vc;
}

- (void) replaceStackWith:(UIViewController*)vc from:(UIViewController*)presenter
{
    SWRevealViewController* reveal = presenter.revealViewController;
    assert(reveal);
    assert(presenter);
    
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [reveal setFrontViewController:nc animated:YES];
}

- (void)present:(UIViewController *)vc from:(UIViewController *)presenter animated:(BOOL)animated
{
    assert(vc);
    assert(presenter);
    UINavigationController* navController = nil;
    if (presenter.revealViewController) {
        assert([presenter.revealViewController.frontViewController isKindOfClass:[UINavigationController class]]);
        SWRevealViewController* reveal = presenter.revealViewController;
        navController = (UINavigationController*) reveal.frontViewController;
    } else {
        navController = presenter.navigationController;
    }
    
    assert(navController);
    [navController pushViewController:vc animated:animated];
}

- (void)presentModal:(UIViewController*)vc
       withPresenter:(UIViewController*)presenter
            animated:(BOOL)animated
{
    [((SWRevealViewController*)self.window.rootViewController) presentViewController:vc
                                                                            animated:YES
                                                                          completion:nil];
}

- (void)dismiss:(UIViewController *)vc
       animated:(BOOL)animated
 withCompletion:(void (^)(UIViewController *))completion
{
    assert(vc);
    if (vc.navigationController && vc.navigationController.viewControllers.count > 1) {
        
        if (vc.navigationController.topViewController != vc) {
            return;
        }
        
        UINavigationController* nav = vc.navigationController;
        [nav popViewControllerAnimated:animated];
        if (completion) {
            completion(nav.topViewController);
        }
        
    } else if (vc.presentingViewController) {
        SWRevealViewController* reveal = (SWRevealViewController*)vc.presentingViewController;
        [reveal dismissViewControllerAnimated:animated completion:nil];
        UINavigationController *nav = (UINavigationController*)reveal.frontViewController;
        if (completion) {
            completion([nav.viewControllers lastObject]);
        }
        
    } else {
        NSLog(@"Trying to dismmis root VC %@", vc);
    }
}

@end
