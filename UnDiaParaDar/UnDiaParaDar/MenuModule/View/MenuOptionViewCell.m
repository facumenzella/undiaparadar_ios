//
//  MenuOptionViewCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/28/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuOptionViewCell.h"
#import "MenuOptionPresenter.h"
#import <PureLayout/PureLayout.h>

@interface MenuOptionViewCell ()

@property (nonatomic, strong) UIImageView *optionImageView;
@property (nonatomic, strong) UILabel *optionLabel;

@end

@implementation MenuOptionViewCell

#pragma mark - MenuOptionViewCell

- (void)cellDidLoad
{
    [super cellDidLoad];
    [self buildOptionImageView];
    [self buildTitle];
}

- (void)buildOptionImageView
{
    self.optionImageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.optionImageView];
    
    [self.optionImageView autoSetDimension:ALDimensionHeight toSize:32];
    [self.optionImageView autoSetDimension:ALDimensionWidth toSize:32];
    [self.optionImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.optionImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
}

- (void)buildTitle
{
    self.optionLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.optionLabel];
    
    [self.optionLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.optionImageView];
    [self.optionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.optionImageView withOffset:16];
    [self.optionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:32];
    [self.optionLabel autoSetDimension:ALDimensionHeight
                             toSize:64
                           relation:NSLayoutRelationLessThanOrEqual];
}

- (void) cellWillAppear
{
    [super cellWillAppear];
    
    MenuOptionPresenter *presenter = (MenuOptionPresenter*)self.item;
    [self.optionImageView setImage: presenter.optionImage];
    [self.optionLabel setText: presenter.option];
    
    [self.contentView layoutIfNeeded];
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 64;
}


@end
