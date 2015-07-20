//
//  LoginView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoginView.h"

#import <UIView+AutoLayout.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginView ()

@property (nonatomic, assign) id<FBSDKLoginButtonDelegate> loginDelegate;

@end

@implementation LoginView

#pragma mark - LoginView

- (instancetype) initWithFacebookLoginDelegate:(id<FBSDKLoginButtonDelegate>)loginDelegate
{
    self = [super init];
    if (self) {
        self.loginDelegate = loginDelegate;
        [self buildSubviews];
    }
    return self;
}

#pragma mark - BuildSubviews

- (void)buildSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self buildLoginButton];
}

- (void)buildLoginButton
{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self.loginDelegate;
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:loginButton];
    [loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [loginButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-24];
}

@end
