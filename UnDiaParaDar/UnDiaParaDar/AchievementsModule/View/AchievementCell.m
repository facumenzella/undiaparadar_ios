//
//  AchievementCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementCell.h"
#import "ButtonFactory.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

static NSString *const kPledge = @"pledge";

@interface AchievementCell ()

@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UILabel *positiveActionTitle;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation AchievementCell

- (void)cellDidLoad
{
    [super cellDidLoad];
    [self buildSubviews];
    [self styleSubviews];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    id <AchievementBaseCellProtocol> item = self.item;
    self.stateImageView.image = [UIImage imageNamed:[item state]];
    self.confirmButton.hidden = ![item confirmEnabled];
}

- (void)buildSubviews
{
    [self buildStateImageView];
    [self buildPositiveActionTitle];
    [self buildConfirmButton];
}

- (void)buildStateImageView
{
    self.stateImageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.stateImageView];
    [self.stateImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    [self.stateImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.stateImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.stateImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                          withInset:0
                                           relation:NSLayoutRelationGreaterThanOrEqual];
    [self.stateImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.stateImageView setImage:[UIImage imageNamed:kPledge]];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.positiveActionTitle];
    [self.positiveActionTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stateImageView withOffset:8];
    [self.positiveActionTitle autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop
                                               withInset:0
                                                relation:NSLayoutRelationGreaterThanOrEqual];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                               withInset:0
                                                relation:NSLayoutRelationGreaterThanOrEqual];
}

- (void)buildConfirmButton
{
    self.confirmButton = [ButtonFactory buttonWithImage:kPledge];
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.confirmButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.positiveActionTitle withOffset:4];
    [self.confirmButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeTop
                                         withInset:0
                                          relation:NSLayoutRelationGreaterThanOrEqual];
    [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                         withInset:0
                                          relation:NSLayoutRelationGreaterThanOrEqual];
}

- (void)styleSubviews
{
    self.positiveActionTitle.textAlignment = NSTextAlignmentLeft;
    self.positiveActionTitle.text = @"t;kasjdfklasdfkadf";
    self.positiveActionTitle.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                   withSize:BeautyCenterTypographySizeC];
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 80;
}

@end
