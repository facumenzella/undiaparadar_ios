//
//  SplashView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SplashView.h"

#import <UIView+AutoLayout.h>

static NSString *BACKGROUND_KEY = @"Splash";
static NSString *UNDIAPARADAR_KEY = @"undiaparadar";

@interface SplashView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *undiaparadarLogoImageView;

@end

@implementation SplashView

#pragma mark - SplashView

- (instancetype)init
{
    if (self = [super init]) {
        [self buildSubviews];
    }
    return self;
}

#pragma mark - Subviews

- (void)buildSubviews
{
    [self buildBackground];
    [self buildUnDiaParaDarLogo];
}

- (void)buildBackground
{
    UIImage *backgroundImage = [UIImage imageNamed:BACKGROUND_KEY];
    self.backgroundImageView = [[UIImageView alloc] initForAutoLayout];
    [self.backgroundImageView setImage:backgroundImage];
    
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)buildUnDiaParaDarLogo
{
    UIImage *undiaparadarLogo = [UIImage imageNamed:UNDIAPARADAR_KEY];
    self.undiaparadarLogoImageView = [[UIImageView alloc] initForAutoLayout];
    [self.undiaparadarLogoImageView setImage:undiaparadarLogo];
    
    [self.backgroundImageView addSubview:self.undiaparadarLogoImageView];
    [self.undiaparadarLogoImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.backgroundImageView];
    [self.undiaparadarLogoImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backgroundImageView];
    [self.undiaparadarLogoImageView setAlpha:0];
}

#pragma mark - SplashViewProtocol

- (void)animate
{
    [UIView animateWithDuration:3 animations:^{
        [self.undiaparadarLogoImageView setAlpha:1];
    }];
}

@end
