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
#import "UILabel+EstimatedHeight.h"

#import <PureLayout/PureLayout.h>

static UILabel *bridgeLabel;
static UIImageView *bridgeStateImageView;
static UIImageView *bridgeCommitImageView;
static UIFont *bridgeFont;

static CGFloat const kLeftInset = 16;
static CGFloat const kLabelLeftOffset = 8;
static CGFloat const kConfirmLeftOffet = 4;

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
    
    id <AchievementBaseCellProtocol> item = (id <AchievementBaseCellProtocol>)self.item;
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
    [self.stateImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLeftInset];
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
    [self.contentView addSubview:self.positiveActionTitle];
    [self.textLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.stateImageView withOffset:kLabelLeftOffset];
    [self.textLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.textLabel autoPinEdgeToSuperviewEdge:ALEdgeTop
                                     withInset:0
                                      relation:NSLayoutRelationGreaterThanOrEqual];
    [self.textLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                     withInset:0
                                      relation:NSLayoutRelationGreaterThanOrEqual];
}

- (void)buildConfirmButton
{
    self.confirmButton = [ButtonFactory buttonWithImage:kPledge];
    [self.contentView addSubview:self.confirmButton];
    [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.confirmButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.textLabel withOffset:kConfirmLeftOffet];
    [self.confirmButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeTop
                                         withInset:0
                                          relation:NSLayoutRelationGreaterThanOrEqual];
    [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                         withInset:0
                                          relation:NSLayoutRelationGreaterThanOrEqual];
    [self.confirmButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.confirmButton addTarget:self action:@selector(pledge) forControlEvents:UIControlEventTouchDown];
}

- (void)styleSubviews
{
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                         withSize:BeautyCenterTypographySizeB];
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bridgeLabel = [[UILabel alloc] initForAutoLayout];
        bridgeFont = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                    withSize:BeautyCenterTypographySizeB];
        bridgeCommitImageView = [[UIImageView alloc] initForAutoLayout];
        bridgeStateImageView = [[UIImageView alloc] initForAutoLayout];
        [AchievementCell styleStateImageView:bridgeStateImageView];
        [AchievementCell styleCommitImageView:bridgeCommitImageView];
    });
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)
    - (CGRectGetWidth(bridgeCommitImageView.bounds) + CGRectGetWidth(bridgeStateImageView.bounds) + kLeftInset + kConfirmLeftOffet + kLabelLeftOffset);
    
    return 40 + [bridgeLabel heightForText:item.title withWidth:width usingFont:bridgeFont];
}

+ (void)styleStateImageView:(UIImageView*)imageView
{
    imageView.image = [UIImage imageNamed:@"newPledge"];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

+ (void)styleCommitImageView:(UIImageView*)imageView
{
    imageView.image = [UIImage imageNamed:kPledge];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)pledge
{
    id<AchievementBaseCellProtocol> it = ((id<AchievementBaseCellProtocol>)self.item);
    [it.delegate pledgeWithItem:it];
}

@end
