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
#import "User.h"

#import <PureLayout/PureLayout.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

static NSString *const HEADER = @"profile_header";
static NSString *const PLACEHOLDER = @"placeholder";
static NSString *const LINK = @"https://www.facebook.com/undiaparadar/";

@interface ProfileView ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) RemoteImageView *userProfileImageView;
@property (nonatomic, strong) UIView *overview;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UILabel *facebookLabel;
@property (nonatomic, strong) FBSDKLikeControl *likeButton;
@property (nonatomic, strong) FBSDKShareButton *shareButton;

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

- (void)populateWithUser:(User*)user
{
    [self.userName setText:user.name];
    [self.userProfileImageView setRemoteURL:user.image200x200];
}

- (void)buildSubviews
{
    [self buildHeader];
    [self buildUserProfileImage];
    [self buildOverview];
    [self buildUserName];
    [self buildDescription];
}

- (void)buildHeader
{
    self.headerImageView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:self.headerImageView];
    [self.headerImageView setImage:[UIImage imageNamed:HEADER]];
    
    [self.headerImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.headerImageView setContentMode:UIViewContentModeScaleAspectFill];
}

- (void)buildUserProfileImage
{
    self.userProfileImageView = [[RemoteImageView alloc] initForAutoLayout];
    [self.headerImageView addSubview:self.userProfileImageView];
    
    [self.userProfileImageView autoSetDimension:ALDimensionHeight toSize:150];
    [self.userProfileImageView autoSetDimension:ALDimensionWidth toSize:150];
    [self.userProfileImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.userProfileImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:32];
    
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
}

- (void)buildUserName
{
    self.userName = [[UILabel alloc] initForAutoLayout];
    [self.overview addSubview:self.userName];
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:16];
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)buildDescription
{
    self.content = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.content];
    
    [self.content autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headerImageView];
    [self.content autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeTop];
    
    [self buildCommingSoon];
    [self buildFacebookLabel];
    [self buildLikeButton];
    [self buildShareButton];
}

- (void)buildCommingSoon
{
    UIImageView *commingSoon = [[UIImageView alloc] initForAutoLayout];
    commingSoon.image = [UIImage imageNamed:@"commingSoon"];
    [self.content addSubview:commingSoon];
    [commingSoon autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [commingSoon autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}

- (void)buildFacebookLabel
{
    self.facebookLabel = [[UILabel alloc] initForAutoLayout];
    self.facebookLabel.text = NSLocalizedString(@"FOLLOW_US", @"Seguinos en Facebook");
    [self.content addSubview:self.facebookLabel];
    [self.facebookLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 8, 0, 16) excludingEdge:ALEdgeBottom];
}

- (void)buildLikeButton
{
    self.likeButton = [[FBSDKLikeControl alloc] initForAutoLayout];
    self.likeButton.objectID = LINK;
    [self.content addSubview:self.likeButton];

    [self.likeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.likeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.facebookLabel withOffset:8];
    [self.likeButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20 relation:NSLayoutRelationGreaterThanOrEqual];
}

- (void)buildShareButton
{
    self.shareButton = [[FBSDKShareButton alloc] initForAutoLayout];
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:LINK];
    self.shareButton.shareContent = content;

    [self.content addSubview:self.shareButton];
    
    [self.shareButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.likeButton withOffset:8];
    [self.shareButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.overview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    [self.userName setBackgroundColor:[UIColor clearColor]];
    [self.userName setTextAlignment:NSTextAlignmentCenter];
    [self.userName setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                          withSize:BeautyCenterTypographySizeE]];
    [self.userName setTextColor: [UIColor whiteColor]];
    
    self.facebookLabel.textAlignment = NSTextAlignmentRight;
    self.facebookLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                             withSize:BeautyCenterTypographySizeC];
}

@end
