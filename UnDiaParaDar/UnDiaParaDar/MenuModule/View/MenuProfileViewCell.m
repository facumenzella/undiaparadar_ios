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
#import <UIView+Autolayout.h>

@interface MenuProfileViewCell ()

@property (nonatomic, strong) RemoteImageView *avatar;
@property (nonatomic, strong) UILabel *username;

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
    
    [self.avatar autoSetDimension:ALDimensionHeight toSize:64];
    [self.avatar autoSetDimension:ALDimensionWidth toSize:64];
    [self.avatar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    
    self.avatar.layer.cornerRadius = 1;
    self.avatar.clipsToBounds = YES;
    
    [self.avatar setPlaceHolderImage:[UIImage imageNamed:@"avatar128x128"]];
}

- (void)buildUsername
{
    self.username = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.username];
    
    [self.username autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatar];
    [self.username autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatar withOffset:16];
    [self.username autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:32];
    [self.username autoSetDimension:ALDimensionHeight
                         toSize:64
                       relation:NSLayoutRelationLessThanOrEqual];
}

- (void) cellWillAppear
{
    [super cellWillAppear];
    
    MenuProfilePresenter *presenter = (MenuProfilePresenter*)self.item;
    [self.avatar setRemoteURL: presenter.userImage];
    [self.username setText: presenter.userName];
    
    [self.contentView layoutIfNeeded];
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 104;
}


#pragma mark - Style

- (void)styleUsername
{
    [self.username setBackgroundColor:[UIColor clearColor]];
}

@end
