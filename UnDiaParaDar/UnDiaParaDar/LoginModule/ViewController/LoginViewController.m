//
//  LoginViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "Routing.h"
#import "FacebookLoginFlow.h"
#import "ParseLoginHound.h"

@interface LoginViewController ()<LoginDelegate, LoginViewDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) FacebookLoginFlow *loginFlow;
@property (nonatomic, strong) ParseLoginHound *hound;

@end

@implementation LoginViewController

#pragma mark - LoginViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.loginFlow = [[FacebookLoginFlow alloc] initWithLoginDelegate:self];
        self.hound = [[ParseLoginHound alloc] init];
    }
    return self;
}

- (void)loadView
{
    self.loginView = [[LoginView alloc] initWithFacebookLoginDelegate:self.loginFlow];
    self.view = self.loginView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.loginView animate];
}

#pragma mark - LoginDelegate

- (void)loginSucceded
{
    NSLog(@"Go to main screen");
    [self.routing showMainPage];
}

- (void)loginDidFail
{
    NSLog(@"Holy shit");
}

#pragma mark - LoginViewDelegate

- (void)login
{
    [self.hound login];
}

@end
