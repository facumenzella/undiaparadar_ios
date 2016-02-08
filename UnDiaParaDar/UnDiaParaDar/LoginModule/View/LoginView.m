//
//  LoginView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoginView.h"

#import <PureLayout/PureLayout.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

static NSString *BACKGROUND_KEY = @"Splash";
static NSString *UNDIAPARADAR_KEY = @"undiaparadar";

@interface LoginView ()

@property (nonatomic, strong) UIImageView *undiaparadarLogoImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSLayoutConstraint *undiaparadarLogoCenterConstraint;
@property (nonatomic, strong) UIView *buttonContainer;
@property (nonatomic, assign) id<LoginViewDelegate> loginDelegate;

@end

@implementation LoginView

#pragma mark - LoginView

- (instancetype) initWithFacebookLoginDelegate:(id<LoginViewDelegate>)loginDelegate
{
    self = [super init];
    if (self) {
        self.loginDelegate = loginDelegate;
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

#pragma mark - BuildSubviews

- (void)buildSubviews
{
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
    self.buttonContainer = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.buttonContainer];
    [self.buttonContainer autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.buttonContainer autoPinEdge:ALEdgeTop
                               toEdge:ALEdgeBottom
                               ofView:self.undiaparadarLogoImageView
                           withOffset:24];
    self.buttonContainer.userInteractionEnabled = YES;
    [self.buttonContainer addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(login)]];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.userInteractionEnabled = NO;
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttonContainer addSubview:loginButton];
    [loginButton autoPinEdgesToSuperviewEdges];
}

- (void)styleSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.buttonContainer.backgroundColor = [UIColor clearColor];
}

- (void)animate
{
    [self layoutIfNeeded];

    self.undiaparadarLogoCenterConstraint.constant = -45;
    [UIView animateWithDuration:.6 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - LoginViewDelegate

- (void)login
{
    [self.loginDelegate login];
}

@end
