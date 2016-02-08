//
//  Routing.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingViewController.h"

@class PositiveAction, MapFilters;

@protocol Routing <NSObject>

- (void)dismissViewController:(UIViewController*)vc withCompletion:(void (^)(UIViewController *))completion;

- (void)showLoginPage;
- (void)showMainPage;
- (void)showProfile;
- (void)showSplash;
- (void)showTopicsSelection;
- (void)showPositiveActionsMapViewControllerWithPresenter:(UIViewController*)vc
                                           withSelectedTopics:(NSArray*)topics;
- (void)showPositiveaction:(PositiveAction*)positiveAction withPresenter:(UIViewController*)vc;
- (void)showPledgeViewControllerForPositiveAction:(PositiveAction*)positiveAction withPresenter:(UIViewController*)vc;
- (void)showPledgeDateAndTimeOptionsForPositiveAction:(PositiveAction*)positiveAction
                                        withPresenter:(UIViewController*)vc;
- (void)showTermsAndConditions;
- (void)showQueEsUDPD;

- (void)showNetworkReachability;
- (void)showLoadingWithPresenter:(UIViewController*)presenter withLoadingBlock:(LoadingBlock)loadingBlock;
- (void)showMapFiltersViewWithMapFilters:(MapFilters*)mapFilters withPresenter:(UIViewController*)presenters;

@end
