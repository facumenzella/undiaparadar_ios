//
//  PopupView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PopupView.h"

#import <PureLayout/PureLayout.h>

static NSString *BACKGROUND_KEY = @"Splash";
static UIEdgeInsets kDefaultInsets = {64, 32, 64, 32};

@interface PopupView ()

@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation PopupView

- (instancetype)init
{
    return [self initWithInsets:kDefaultInsets];
}

- (instancetype)initWithInsets:(UIEdgeInsets)insets
{
    self = [super init];
    if (self) {
        self.insets = insets;
        [self pBuildSubviews];
        [self pStyleSubviews];
    }
    return self;
}

- (void)pBuildSubviews
{
    [self buildContainerView];
}

- (void)buildContainerView
{
    self.containerView = [[UIImageView alloc] initForAutoLayout];
    self.containerView.image = [UIImage imageNamed:BACKGROUND_KEY];
    self.containerView.userInteractionEnabled = YES;
    [super addSubview:self.containerView];
    
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeTop
                                         withInset:self.insets.top
                                          relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.insets.left];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.insets.right];

    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                         withInset:self.insets.bottom
                                          relation:NSLayoutRelationGreaterThanOrEqual];

    [self.containerView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)pStyleSubviews
{
    self.backgroundColor = [UIColor clearColor];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 30;
    self.containerView.clipsToBounds = YES;
}

- (void)addSubview:(UIView *)view
{
    [self.containerView addSubview:view];
}

@end
