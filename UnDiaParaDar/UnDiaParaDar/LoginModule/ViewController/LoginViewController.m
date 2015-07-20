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

@interface LoginViewController ()<LoginDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) FacebookLoginFlow *loginFlow;

@end

@implementation LoginViewController

#pragma mark - LoginViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.loginFlow = [[FacebookLoginFlow alloc] initWithLoginDelegate:self];
    }
    return self;
}

- (void)loadView
{
    self.view = [[LoginView alloc] initWithFacebookLoginDelegate:self.loginFlow];
}

#pragma mark - LoginDelegate

- (void)loginSucceded
{
    NSLog(@"Go to main screen");
}

- (void)loginDidFail
{
    NSLog(@"Holy shit");
}
@end
