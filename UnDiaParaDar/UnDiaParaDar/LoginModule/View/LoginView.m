//
//  LoginView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoginView.h"
#import "FacebookLoginFlow.h"

#import <UIView+AutoLayout.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

static NSString *BACKGROUND_KEY = @"Splash";
static NSString *UNDIAPARADAR_KEY = @"undiaparadar";

@interface LoginView ()

@property (nonatomic, strong) UIImageView *undiaparadarLogoImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSLayoutConstraint *undiaparadarLogoCenterConstraint;
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
    [self buildBackground];
    [self buildUnDiaParaDarLogo];
    [self buildLoginButton];
}

- (void)buildBackground
{
    UIImage *background = [UIImage imageNamed:BACKGROUND_KEY];
    self.backgroundImageView = [[UIImageView alloc] initForAutoLayout];
    [self.backgroundImageView setImage:background];
    
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)buildUnDiaParaDarLogo
{
    UIImage *undiaparadarLogo = [UIImage imageNamed:UNDIAPARADAR_KEY];
    self.undiaparadarLogoImageView = [[UIImageView alloc] initForAutoLayout];
    [self.undiaparadarLogoImageView setImage:undiaparadarLogo];
    
    [self addSubview:self.undiaparadarLogoImageView];
    [self.undiaparadarLogoImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.backgroundImageView];
    self.undiaparadarLogoCenterConstraint = [self.undiaparadarLogoImageView
                                             autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)buildLoginButton
{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = [FacebookLoginFlow readPermissions];
    loginButton.delegate = self.loginDelegate;
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:loginButton];
    [loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [loginButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.undiaparadarLogoImageView withOffset:24];
}

- (void)animate
{
    [self layoutIfNeeded];

    self.undiaparadarLogoCenterConstraint.constant = -45;
    [UIView animateWithDuration:.6 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
