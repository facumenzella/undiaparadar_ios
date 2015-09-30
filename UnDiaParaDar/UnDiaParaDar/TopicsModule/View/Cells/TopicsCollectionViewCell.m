//
//  TopicCollectionViewCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsCollectionViewCell.h"
#import "Topic.h"
#import "TopicCellPresenter.h"
#import <PureLayout/PureLayout.h>

@interface TopicsCollectionViewCell ()

@property (nonatomic, strong) UIImageView *topicImageView;
@property (nonatomic, strong) UILabel *topicLabel;

@end

@implementation TopicsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildSubviews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildTopicImageView];
    [self buildTopicLabel];
    [self styleCellSubviews];
}

 - (void)buildTopicImageView
{
    self.topicImageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.topicImageView];
    [self.topicImageView autoSetDimension:ALDimensionWidth toSize:75];
    [self.topicImageView autoSetDimension:ALDimensionHeight toSize:74];
    [self.topicImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.topicImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [self.topicImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
}

- (void)buildTopicLabel
{
    self.topicLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.topicLabel];
    // we do this to force two lines in autolayout
    [self.topicLabel setText:@"DefaultDefaultDefault"];
    [self.topicLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topicImageView];
    [self.topicLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.topicLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.topicLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

 - (void)styleCellSubviews
{
    [self styleTopicTextView];
}

 - (void)styleTopicTextView
{
    self.topicLabel.textAlignment = NSTextAlignmentCenter;
    [self.topicLabel setFont:[UIFont systemFontOfSize:14]];
    [self.topicLabel setBackgroundColor:[UIColor clearColor]];
    [self.topicLabel setTextColor: [UIColor blackColor]];
}

- (void)populateCellWithTopic:(TopicCellPresenter *)presenter
{
    NSString *img = presenter.image;
    if (presenter.selected) {
        img = presenter.selectedImage;
    }
    UIImage *topicImage = [UIImage imageNamed: img];
    [self.topicImageView setImage:topicImage];
    
    [self.topicLabel setText:presenter.name];
}

@end
