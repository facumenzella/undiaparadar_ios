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
#import "PositiveActionsWithMapViewController.h"   

@interface SWRevealRouting ()

@property (nonatomic, strong) id<Director> director;
@property (nonatomic, strong) id<Architect> architect;
@property (nonatomic, strong) id<Tailor> tailor;

@property (nonatomic, strong) LoginModuleAssembly *loginModuleAssembly;
@property (nonatomic, strong) ProfileModuleAssembly *profileModuleAssembly;
@property (nonatomic, strong) SplashModuleAssembly *splashModuleAssembly;
@property (nonatomic, strong) TopicsModuleAssembly *topicsModuleAssembly;

@end

@implementation SWRevealRouting

- (instancetype)initWithDirector:(id<Director>)director
         withLoginModuleAssembly:(LoginModuleAssembly*)loginModuleAssembly
       withProfileModuleAssembly:(ProfileModuleAssembly*)profileModuleAssembly
        withSplashModuleAssembly:(SplashModuleAssembly*)splashModuleAssembly
        withTopicsModuleAssembly:(TopicsModuleAssembly*)topicsModuleAssembly
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

- (void)showPositiveActionsWithMapViewControllerWithPresenter:(UIViewController*)vc
                                           withSelectedTopics:(NSArray*)topics
{
    PositiveActionsWithMapViewController *mapViewController = [self.topicsModuleAssembly
                                                               positiveActionsWithMapViewController];
    [self.director present:mapViewController from:vc animated:YES];
}

@end
