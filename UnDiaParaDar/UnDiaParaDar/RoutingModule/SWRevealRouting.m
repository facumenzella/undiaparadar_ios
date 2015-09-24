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
#import "PositiveActionsMapViewController.h"

#import "TermsAndConditionsAssembly.h"
#import "TermsAndConditionsViewController.h"

#import "QueEsModuleAssembly.h"
#import "QueEsViewController.h"

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

@end

@implementation SWRevealRouting

- (instancetype)initWithDirector:(id<Director>)director
         withLoginModuleAssembly:(LoginModuleAssembly*)loginModuleAssembly
       withProfileModuleAssembly:(ProfileModuleAssembly*)profileModuleAssembly
        withSplashModuleAssembly:(SplashModuleAssembly*)splashModuleAssembly
        withTopicsModuleAssembly:(TopicsModuleAssembly*)topicsModuleAssembly
  withTermsAndConditionsAssembly:(TermsAndConditionsAssembly*)termsAndConditionsAssembly
         withQueEsModuleAssembly:(QueEsModuleAssembly*)queEsModuleAssembly
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
        self.architect = architect;
        self.tailor = tailor;
    }
    return self;
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
    [self showMainPage];
}

- (void)showSplash
{
    SplashViewController *splashViewController = [self.splashModuleAssembly splashViewController];
    [self.director setRoot:splashViewController];
}

- (void)showPositiveActionsMapViewControllerWithPresenter:(UIViewController*)vc
                                           withSelectedTopics:(NSArray*)topics
{
    PositiveActionsMapViewController *mapViewController = [self.topicsModuleAssembly
                                                               positiveActionsMapViewController];
    [self.director present:mapViewController from:vc animated:YES];
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

@end
