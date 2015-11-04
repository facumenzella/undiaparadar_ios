//
//  TopicsFilterViewCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsFilterViewCell.h"
#import "TopicCellPresenter.h"
#import "TopicsSelectedCell.h"
#import <PureLayout/PureLayout.h>

@interface TopicsFilterViewCell ()

@property (nonatomic, strong) UIImageView *topicImageView;

@end

@implementation TopicsFilterViewCell

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
}

- (void)buildTopicImageView
{
    self.topicImageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.topicImageView];
    [self.topicImageView autoSetDimension:ALDimensionWidth toSize:35];
    [self.topicImageView autoSetDimension:ALDimensionHeight toSize:34];
    [self.topicImageView autoPinEdgesToSuperviewEdges];
}

- (void)populateCellWithTopic:(TopicCellPresenter *)presenter
{
    NSString *img = presenter.image;
    if (presenter.selected) {
        img = presenter.selectedImage;
    }
    UIImage *topicImage = [UIImage imageNamed: img];
    [self.topicImageView setImage:topicImage];
}


@end
