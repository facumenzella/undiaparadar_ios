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
#import <PureLayout/PureLayout.h>

static NSString * const PLACEHOLDER = @"placeholder";

@interface MenuProfileViewCell ()

@property (nonatomic, strong) RemoteImageView *avatar;
@property (nonatomic, strong) UITextView *usernameTextView;

@end

@implementation MenuProfileViewCell

#pragma mark - MenuProfileViewCell

- (void)cellDidLoad
{
    [super cellDidLoad];
    [self setBackgroundColor:[UIColor colorWithRed:187/255.0
                                             green:42/255.0
                                              blue:48/255.0
                                             alpha:1]];
    [self buildAvatar];
    [self buildUsername];
}

- (void)buildAvatar
{
    self.avatar = [[RemoteImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.avatar];
    
    [self.avatar autoSetDimension:ALDimensionHeight toSize:70];
    [self.avatar autoSetDimension:ALDimensionWidth toSize:70];
    [self.avatar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    
    self.avatar.layer.cornerRadius = 35;
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.borderWidth = 3.0f;
    self.avatar.layer.borderColor = [UIColor whiteColor].CGColor;

    
    [self.avatar setPlaceHolderImage:[UIImage imageNamed:PLACEHOLDER]];
}

- (void)buildUsername
{
    self.usernameTextView = [[UITextView alloc] initForAutoLayout];
    self.usernameTextView.scrollEnabled = NO;
    [self.contentView addSubview:self.usernameTextView];
    
    [self.usernameTextView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatar];
    [self.usernameTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatar withOffset:16];
    [self.usernameTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:32];
//    [self.username autoSetDimension:ALDimensionHeight
//                         toSize:64
//                       relation:NSLayoutRelationLessThanOrEqual];
}

- (void) cellWillAppear
{
    [super cellWillAppear];
    
    [self styleUsername];
    
    MenuProfilePresenter *presenter = (MenuProfilePresenter*)self.item;
    [self.avatar setRemoteURL: presenter.userImage];
    [self.usernameTextView setText: presenter.userName];
    
    [self.contentView layoutIfNeeded];
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 140;
}


#pragma mark - Style

- (void)styleUsername
{
    [self.usernameTextView setBackgroundColor:[UIColor clearColor]];
    [self.usernameTextView setFont:[UIFont systemFontOfSize:25]];
}

@end
