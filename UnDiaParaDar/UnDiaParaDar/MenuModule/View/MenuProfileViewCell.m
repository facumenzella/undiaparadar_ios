//
//  MenuProfileViewCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuProfileViewCell.h"
#import "MenuProfilePresenter.h"
#import "RemoteImageView.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

static NSString * const PLACEHOLDER = @"placeholder";
static NSString * const BACKGROUND = @"menu_header";

@interface MenuProfileViewCell ()

@property (nonatomic, strong) RemoteImageView *avatar;
@property (nonatomic, strong) UIView *redContainer;
@property (nonatomic, strong) UITextView *usernameTextView;

@end

@implementation MenuProfileViewCell

#pragma mark - MenuProfileViewCell

- (void)cellDidLoad
{
    [super cellDidLoad];

    [self buildBackground];
    [self buildAvatar];
    [self buildRedUserInfoContainer];
    [self buildUsername];
}

- (void)buildBackground
{
    UIImageView *background = [[UIImageView alloc] initForAutoLayout];
    [background setContentMode:UIViewContentModeScaleAspectFill];

    [self.contentView addSubview:background];
    
    [background setImage: [UIImage imageNamed:BACKGROUND]];
    [background autoPinEdgesToSuperviewEdges];
}

- (void)buildAvatar
{
    self.avatar = [[RemoteImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.avatar];
    
    [self.avatar autoSetDimension:ALDimensionHeight toSize:70];
    [self.avatar autoSetDimension:ALDimensionWidth toSize:70];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:24];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    
    self.avatar.layer.cornerRadius = 35;
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.borderWidth = 3.0f;
    self.avatar.layer.borderColor = [UIColor whiteColor].CGColor;

    [self.avatar setPlaceHolderImage:[UIImage imageNamed:PLACEHOLDER]];
}

- (void)buildRedUserInfoContainer
{
    self.redContainer = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:self.redContainer];
    
    [self.redContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatar withOffset:8];
    [self.redContainer autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.redContainer autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
}

- (void)buildUsername
{
    self.usernameTextView = [[UITextView alloc] initForAutoLayout];
    self.usernameTextView.scrollEnabled = NO;
    [self.redContainer addSubview:self.usernameTextView];
    
    [self.usernameTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.usernameTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    [self.usernameTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:4];
    [self.usernameTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

- (void) cellWillAppear
{
    [super cellWillAppear];
    
    [self styleSubviews];
    
    MenuProfilePresenter *presenter = (MenuProfilePresenter*)self.item;
    [self.avatar setRemoteURL: presenter.userImage];
    [self.usernameTextView setText: presenter.userName];
    
    [self.contentView layoutIfNeeded];
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 160;
}


#pragma mark - Style

- (void)styleSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self styleRedContainer];
    [self styleUsername];
}

- (void)styleRedContainer
{
    [self.redContainer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
}

- (void)styleUsername
{
    [self.usernameTextView setBackgroundColor:[UIColor clearColor]];
    [self.usernameTextView setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleMedium
                                                                  withSize:BeautyCenterTypographySizeD]];
    [self.usernameTextView setTextColor: [UIColor whiteColor]];
    self.usernameTextView.editable = NO;
}

@end
