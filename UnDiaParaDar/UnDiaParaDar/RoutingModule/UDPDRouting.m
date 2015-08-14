//
//  UDPDRouting.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "UDPDRouting.h"
#import "Director.h"
#import "Architect.h"

#import "LoginModuleAssembly.h"
#import "LoginViewController.h"

#import "ProfileModuleAssembly.h"
#import "ProfileViewController.h"

#import "SplashModuleAssembly.h"
#import "SplashViewController.h"

@interface UDPDRouting ()

@property (nonatomic, strong) id<Director> director;
@property (nonatomic, strong) id<Architect> architect;

@property (nonatomic, strong) LoginModuleAssembly *loginModuleAssembly;
@property (nonatomic, strong) ProfileModuleAssembly *profileModuleAssembly;
@property (nonatomic, strong) SplashModuleAssembly *splashModuleAssembly;

@end

@implementation UDPDRouting

- (instancetype)initWithDirector:(id<Director>)director
         withLoginModuleAssembly:(LoginModuleAssembly*)loginModuleAssembly
       withProfileModuleAssembly:(ProfileModuleAssembly*)profileModuleAssembly
        withSplashModuleAssembly:(SplashModuleAssembly*)splashModuleAssemlby
                   withArchitect:(id<Architect>)architect
{
    self = [super init];
    if (self) {
        self.director = director;
        self.loginModuleAssembly = loginModuleAssembly;
        self.profileModuleAssembly = profileModuleAssembly;
        self.splashModuleAssembly = splashModuleAssemlby;
        self.architect = architect;
    }
    return self;
}

- (void)showLoginPage
{
    [self.director setRoot:[self.loginModuleAssembly loginViewController]];
}

- (void)showMainPage
{
    ProfileViewController *profileViewController = [self.profileModuleAssembly profileViewController];
    [self.director setRoot:[self.architect buildMainScreenWithRootViewController: profileViewController]];
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


@end
