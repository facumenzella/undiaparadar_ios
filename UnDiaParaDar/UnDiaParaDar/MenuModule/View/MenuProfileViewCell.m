//
//  MenuProfileViewCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuProfileViewCell.h"
#import <UIView+Autolayout.h>

@interface MenuProfileViewCell ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *username;

@end

@implementation MenuProfileViewCell

#pragma mark - MenuProfileViewCell

- (void)cellDidLoad
{
    [super cellDidLoad];
    [self buildAvatar];
    [self buildUsername];
}

- (void)buildAvatar
{
    self.avatar = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.avatar];
    
    [self.avatar autoSetDimension:ALAxisVertical toSize:64];
    [self.avatar autoSetDimension:ALAxisHorizontal toSize:64];
    [self.avatar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    
    self.avatar.layer.cornerRadius = 1;
    self.avatar.clipsToBounds = YES;
}

- (void)buildUsername
{
    self.username = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.username];
    
    [self.username autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatar];
    [self.username autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatar withOffset:16];
    [self autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:32];
    [self.username autoSetDimension:ALDimensionHeight
                         toSize:64
                       relation:NSLayoutRelationLessThanOrEqual];
}

- (void) cellWillAppear
{
    [super cellWillAppear];
    
    [self.avatar setImage:[UIImage imageNamed:@"avatar_128x128.png"]];
    [self.username setText:@"Jon Snow"];
    
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
