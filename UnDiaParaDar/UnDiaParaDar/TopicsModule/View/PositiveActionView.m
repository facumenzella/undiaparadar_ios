//
//  PositiveActionView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionView.h"

#import <PureLayout/PureLayout.h>

static NSString * const BACKGROUND = @"menu_header";

@interface PositiveActionView ()

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) UIImageView *mainHeaderView;
@property (nonatomic, strong) UIView *descriptionContainer;
@property (nonatomic, strong) UILabel *positiveActionTitle;
@property (nonatomic, strong) UIImageView *colorBandImageView;
@property (nonatomic, strong) UITextView *positiveActionDescription;

@end

@implementation PositiveActionView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    self.container = [[UIScrollView alloc] initForAutoLayout];
    [self addSubview:self.container];
    [self.container autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self buildHeader];
    [self buildDescriptionContainer];
    [self buildPositiveActionTitle];
    [self buildTitleUnderline];
    [self buildPositiveActionDescription];
}

- (void)buildHeader
{
    self.mainHeaderView = [[UIImageView alloc] initForAutoLayout];
    [self.mainHeaderView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.container addSubview:self.mainHeaderView];
    
    [self.mainHeaderView setImage: [UIImage imageNamed:BACKGROUND]];
    [self.mainHeaderView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
}

- (void)buildDescriptionContainer
{
    self.descriptionContainer = [[UIView alloc] initForAutoLayout];
    [self.container addSubview:self.descriptionContainer];
    [self.container autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainHeaderView];
    [self.descriptionContainer autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UILabel alloc] initForAutoLayout];
    [self.descriptionContainer addSubview: self.positiveActionTitle];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    
    // TODO MOCK TEXT
    self.positiveActionTitle.text = @"Sumate a nuestra campaña \"NO SELFIE\"";
}

- (void)buildTitleUnderline
{
    self.colorBandImageView = [[UIImageView alloc] initForAutoLayout];
    UIImage *colorBand = [UIImage imageNamed:@"color_band"];
    [self.colorBandImageView setImage: colorBand];
    
    [self.container addSubview: self.colorBandImageView];
    [self.colorBandImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView: self.positiveActionTitle withOffset:8];
    [self.colorBandImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.colorBandImageView autoMatchDimension:ALDimensionWidth
                                    toDimension:ALDimensionWidth
                                         ofView:self.positiveActionTitle];
}

- (void)buildPositiveActionDescription
{
    self.positiveActionDescription = [[UITextView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview: self.positiveActionDescription];
    [self.positiveActionDescription autoPinEdge:ALEdgeTop
                                         toEdge:ALEdgeBottom
                                         ofView:self.colorBandImageView
                                     withOffset:8];
    [self.positiveActionDescription autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionDescription autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    [self.positiveActionDescription autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:24];
    self.positiveActionDescription.scrollEnabled = NO;
    self.positiveActionDescription.editable = NO;
    // TODO MOCK TEXT
    self.positiveActionDescription.text = @"Te invitamos a que cuando dones sangre te saques una foto como esta y que despues compartas la foto en tus redes sociales usando el hashtag \'#NOSelfie\'";
}


- (void)styleSubviews
{
    // Here you should style every subviews
}

@end
