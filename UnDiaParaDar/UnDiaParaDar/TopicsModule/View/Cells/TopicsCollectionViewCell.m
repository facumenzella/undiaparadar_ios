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
@property (nonatomic, strong) UITextView *topicTextView;

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
    [self buildTopicTextView];
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

- (void)buildTopicTextView
{
    self.topicTextView = [[UITextView alloc] initForAutoLayout];
    self.topicTextView.scrollEnabled = NO;
    [self.contentView addSubview:self.topicTextView];
    // we do this to force two lines in autolayout
    [self.topicTextView setText:@"DefaultDefaultDefault"];
    [self.topicTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topicImageView];
    [self.topicTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.topicTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.topicTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

 - (void)styleCellSubviews
{
    [self styleTopicTextView];
}

 - (void)styleTopicTextView
{
    self.topicTextView.textAlignment = NSTextAlignmentCenter;
    [self.topicTextView setFont:[UIFont systemFontOfSize:14]];
    [self.topicTextView setBackgroundColor:[UIColor clearColor]];
}

- (void)populateCellWithTopic:(TopicCellPresenter *)presenter
{
    NSString *img = presenter.image;
    if (presenter.selected) {
        img = presenter.selectedImage;
    }
    UIImage *topicImage = [UIImage imageNamed: img];
    [self.topicImageView setImage:topicImage];
    
    [self.topicTextView setText:NSLocalizedString(presenter.name, "topic")];
    [self.topicTextView setTextColor: [UIColor blackColor]];
}

@end
