//
//  ProfileView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/6/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ProfileView.h"
#import "RemoteImageView.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

static NSString *const HEADER = @"menu_header";
static NSString *const PLACEHOLDER = @"placeholder";

@interface ProfileView ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) RemoteImageView *userProfileImageView;
@property (nonatomic, strong) UIView *overview;
@property (nonatomic, strong) UILabel *userName;

@end

@implementation ProfileView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildHeader];
    [self buildUserProfileImage];
    [self buildOverview];
    [self buildDescription];
}

- (void)buildHeader
{
    self.headerImageView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:self.headerImageView];
    [self.headerImageView setImage:[UIImage imageNamed:HEADER]];
    
    [self.headerImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.headerImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.headerImageView autoSetDimension:ALDimensionHeight toSize:250];
}

- (void)buildUserProfileImage
{
    self.userProfileImageView = [[RemoteImageView alloc] initForAutoLayout];
    [self.headerImageView addSubview:self.userProfileImageView];
    
    [self.userProfileImageView autoSetDimension:ALDimensionHeight toSize:150];
    [self.userProfileImageView autoSetDimension:ALDimensionWidth toSize:150];
    [self.userProfileImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.userProfileImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:24];
    
    self.userProfileImageView.layer.cornerRadius = 75;
    self.userProfileImageView.clipsToBounds = YES;
    self.userProfileImageView.layer.borderWidth = 3.0f;
    self.userProfileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.userProfileImageView setPlaceHolderImage:[UIImage imageNamed:PLACEHOLDER]];
}

- (void)buildOverview
{
    self.overview = [[UIView alloc] initForAutoLayout];
    [self.headerImageView addSubview:self.overview];
    
    [self.overview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userProfileImageView withOffset:8];
    [self.overview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.overview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.overview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
}

- (void)buildUserName
{
    self.userName = [[UILabel alloc] initForAutoLayout];
    [self.overview addSubview:self.userName];
    [self.userName autoPinEdgesToSuperviewEdges];
}

- (void)buildDescription
{
    UIView *description = [[UIView alloc] initForAutoLayout];
    [self addSubview:description];
    
    [description autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headerImageView];
    [description autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeTop];
}

- (void)styleSubviews
{
    [self.overview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    [self.userName setBackgroundColor:[UIColor clearColor]];
    [self.userName setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleMedium
                                                          withSize:BeautyCenterTypographySizeD]];
    [self.userName setTextColor: [UIColor whiteColor]];
    
}

@end
