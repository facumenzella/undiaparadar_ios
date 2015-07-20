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

@implementation LoginView

#pragma mark - LoginView

- (instancetype) init
{
    self = [super init];
    if (self) {
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
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:loginButton];
    [loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [loginButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-24];
}

@end
