//
//  SWRevealRouting.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SWRevealRouting.h"
#import "Director.h"
#import "Architect.h"
#import "Tailor.h"

#import "LoginModuleAssembly.h"
#import "LoginViewController.h"

#import "ProfileModuleAssembly.h"
#import "ProfileViewController.h"

#import "SplashModuleAssembly.h"
#import "SplashViewController.h"

#import "TopicsModuleAssembly.h"
#import "TopicsCollectionViewController.h"
#import "PositiveActionsFilteredWithMapViewController.h"
#import "PositiveActionViewController.h"
#import "MapFiltersViewController.h"
#import "PledgeViewController.h"
#import "PledgeDateAndTimeViewController.h"

#import "TermsAndConditionsAssembly.h"
#import "TermsAndConditionsViewController.h"

#import "QueEsModuleAssembly.h"
#import "QueEsViewController.h"

#import "LoadingModuleAssembly.h"
#import "LoadingViewController.h"

#import "NetworkReachabilityAssembly.h"
#import "NetworkViewController.h"


@interface SWRevealRouting ()

@property (nonatomic, strong) id<Director> director;
@property (nonatomic, strong) id<Architect> architect;
@property (nonatomic, strong) id<Tailor> tailor;

@property (nonatomic, strong) LoginModuleAssembly *loginModuleAssembly;
@property (nonatomic, strong) ProfileModuleAssembly *profileModuleAssembly;
@property (nonatomic, strong) SplashModuleAssembly *splashModuleAssembly;
@property (nonatomic, strong) TopicsModuleAssembly *topicsModuleAssembly;
@property (nonatomic, strong) TermsAndConditionsAssembly *termsAndConditionsAssembly;
@property (nonatomic, strong) QueEsModuleAssembly *queEsModuleAssembly;
@property (nonatomic, strong) LoadingModuleAssembly *loadingModuleAssembly;
@property (nonatomic, strong) NetworkReachabilityAssembly *networkModuleAssembly;

@end

@implementation SWRevealRouting

- (instancetype)initWithDirector:(id<Director>)director
         withLoginModuleAssembly:(LoginModuleAssembly*)loginModuleAssembly
       withProfileModuleAssembly:(ProfileModuleAssembly*)profileModuleAssembly
        withSplashModuleAssembly:(SplashModuleAssembly*)splashModuleAssembly
        withTopicsModuleAssembly:(TopicsModuleAssembly*)topicsModuleAssembly
  withTermsAndConditionsAssembly:(TermsAndConditionsAssembly*)termsAndConditionsAssembly
         withQueEsModuleAssembly:(QueEsModuleAssembly*)queEsModuleAssembly
       withLoadingModuleAssembly:(LoadingModuleAssembly*)loadingModuleAssembly
 withNetworkReachabilityAssembly:(NetworkReachabilityAssembly*)networkModuleAssembly
                   withArchitect:(id<Architect>)architect
                      withTailor:(id<Tailor>)tailor
{
    self = [super init];
    if (self) {
        self.director = director;
        self.loginModuleAssembly = loginModuleAssembly;
        self.profileModuleAssembly = profileModuleAssembly;
        self.splashModuleAssembly = splashModuleAssembly;
        self.topicsModuleAssembly = topicsModuleAssembly;
        self.termsAndConditionsAssembly = termsAndConditionsAssembly;
        self.queEsModuleAssembly = queEsModuleAssembly;
        self.loadingModuleAssembly = loadingModuleAssembly;
        self.networkModuleAssembly = networkModuleAssembly;
        self.architect = architect;
        self.tailor = tailor;
    }
    return self;
}

- (void)dismissViewController:(UIViewController*)vc withCompletion:(void (^)(UIViewController *))completion
{
    [self.director dismiss:vc animated:YES withCompletion:completion];
}


- (void)showLoginPage
{
    [self.director setRoot:[self.loginModuleAssembly loginViewController]];
}

- (void)showMainPage
{
    [self showTopicsSelection];
}

- (void)showTopicsSelection
{
    TopicsCollectionViewController *topicsViewController = [self.topicsModuleAssembly topicsCollectionViewController];
    [self.tailor suitViewControllerUpForNextEvent:topicsViewController];
    [self.director setRoot:[self.architect buildMainScreenWithRootViewController: topicsViewController]];
}

- (void)showProfile
{
    ProfileViewController *profileViewController = [self.profileModuleAssembly profileViewController];
    [self.director setRoot:[self.architect buildMainScreenWithRootViewController: profileViewController]];
}

- (void)showSplash
{
    SplashViewController *splashViewController = [self.splashModuleAssembly splashViewController];
    [self.director setRoot:splashViewController];
}


- (void)showPositiveActionsMapViewControllerWithSelectedTopics:(NSArray*)topics
{
    PositiveActionsFilteredWithMapViewController *mapViewController = [self.topicsModuleAssembly
                                                                       positiveActionsMapViewControllerWithTopics:topics];
    [self.tailor suitViewControllerUpForFilterEvent:mapViewController];
    [self.director setRoot:[self.architect buildMainScreenWithRootViewController: mapViewController]];
}

- (void)showPositiveActionsMapViewControllerWithPresenter:(UIViewController*)vc
                                       withSelectedTopics:(NSArray*)topics
{
    if (vc) {
        PositiveActionsFilteredWithMapViewController *mapViewController =
        [self.topicsModuleAssembly positiveActionsMapViewControllerWithTopics:topics];
        [self.tailor suitViewControllerUpForFilterEvent:mapViewController];
        [self.director present:mapViewController from:vc animated:YES];
        return;
    }
    [self showPositiveActionsMapViewControllerWithSelectedTopics:topics];
}

- (void)showPositiveaction:(PositiveAction*)positiveAction withPresenter:(UIViewController*)vc
{
    PositiveActionViewController *positive = [self.topicsModuleAssembly
                                              positiveActionViewControllerWithPositiveAction:positiveAction];
    [self.director present:positive from:vc animated:YES];
}

- (void)showPledgeViewControllerWithPresenter:(UIViewController *)vc
{
    PledgeViewController *pledge = [self.topicsModuleAssembly pledgeViewController];
    [self.director presentModal:pledge withPresenter:vc animated:YES];
}

- (void)showPledgeDateAndTimeOptionsWithPresenter:(UIViewController*)vc
{
    PledgeDateAndTimeViewController *pledge = [self.topicsModuleAssembly pledgeDateAndTimeViewController];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pledge];
    
    [self.tailor suitViewControllerUpForCancelEvent:pledge];
    
    [self.director presentModal:nav withPresenter:vc animated:YES];
}

- (void)showTermsAndConditions
{
    TermsAndConditionsViewController *tyc = [self.termsAndConditionsAssembly termsAndConditionsViewController];
    [self.director setRoot:[self.architect buildMainScreenWithRootViewController: tyc]];
}

- (void)showQueEsUDPD
{
    QueEsViewController *queEsVC = [self.queEsModuleAssembly queEsViewController];
    [self.director setRoot:[self.architect buildMainScreenWithRootViewController: queEsVC]];
}

- (void)showLoadingWithPresenter:(UIViewController*)presenter withLoadingBlock:(LoadingBlock)loadingBlock
{
    LoadingViewController *loading = [self.loadingModuleAssembly loadingViewControllerWithLoadingBlock:loadingBlock];
    [self.director presentModal:loading withPresenter:presenter animated:YES];
}

- (void)showNetworkReachability
{
    NetworkViewController *net = [self.networkModuleAssembly networkViewController];
    [self.director presentModal:net withPresenter:nil animated:YES];
}

- (void)showMapFiltersViewWithMapFilters:(MapFilters *)mapFilters withPresenter:(UIViewController *)presenters
{
    MapFiltersViewController *vc = [self.topicsModuleAssembly mapFiltersViewControllerWithMapFilters:mapFilters];
    [self.director presentModal:vc withPresenter:presenters animated:YES];
}

@end
