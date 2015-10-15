//
//  TopicsSelectedCell.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsSelectedCell.h"
#import "Topic.h"
#import "BeautyCenter.h"
#import "UIImage+AverageColor.h"
#import "UIColor+Transformation.h"

#import <PureLayout/PureLayout.h>

@interface TopicsSelectedCell ()

@property (nonatomic, strong) Topic *topic;

@property (nonatomic, strong) UIImageView *topicImageView;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UILabel *cross;

@end

@implementation TopicsSelectedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 10;
        self.contentView.clipsToBounds = YES;

        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)populateWithTopic:(Topic*)topic
{
    self.topic = topic;
    [self.topicImageView setImage:[UIImage imageNamed:topic.img40x40On]];

    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.topic.code isEqualToString:topic.code]) {
            [self.contentView setBackgroundColor:[[self.topicImageView.image averageColor] lightenWithTintFactor:.2]];
        }
    });
}

-(void)prepareForReuse
{
    [self.contentView setBackgroundColor:[UIColor clearColor]];
}

- (void)buildSubviews
{
    [self buildTopicImage];
    [self buildSeparator];
    [self buildCross];
}

- (void)buildTopicImage
{
    self.topicImageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.topicImageView];
    
    [self.topicImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [self.topicImageView autoSetDimension:ALDimensionHeight toSize:24];
    [self.topicImageView autoSetDimension:ALDimensionWidth toSize:24];
    [self.topicImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)buildSeparator
{
    self.separator = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:self.separator];
    
    [self.separator autoSetDimension:ALDimensionWidth toSize:1];
    [self.separator autoSetDimension:ALDimensionHeight toSize:32];
    [self.separator autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.separator autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.topicImageView withOffset:8];
    [self.separator autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.separator autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

- (void)buildCross
{
    self.cross = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.cross];
    [self.cross autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.separator withOffset:8];
    [self.cross autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.cross autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.cross setText:@"x"];
}

- (void)styleSubviews
{
    [self.separator setBackgroundColor:[UIColor whiteColor]];
    [self.cross setTextColor:[UIColor whiteColor]];
    [self.cross setBackgroundColor:[UIColor clearColor]];
}

@end
