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

@interface LoginViewController ()

@property (nonatomic, strong) id<Routing> routing;

@end

@implementation LoginViewController

#pragma mark - LoginViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

- (void)loadView
{
    self.view = [[LoginView alloc] init];
}

@end
