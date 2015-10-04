//
//  PositiveActionView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionView.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

static NSString * const BACKGROUND = @"menu_header";

@interface PositiveActionView ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *mainHeaderView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UITextView *overTitleTextView;
@property (nonatomic, strong) UIView *descriptionContainer;
@property (nonatomic, strong) UITextView *positiveActionTitle;
@property (nonatomic, strong) UIImageView *colorBandImageView;
@property (nonatomic, strong) UITextView *positiveActionDescription;
@property (nonatomic, strong) UIView *redBand;


@end

@implementation PositiveActionView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initForAutoLayout];
    [self addSubview:scrollView];
    [scrollView autoPinEdgesToSuperviewEdges];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.container = [[UIView alloc] initForAutoLayout];
    [scrollView addSubview:self.container];
    [self.container autoSetDimension:ALDimensionWidth toSize:screenWidth];
    [self.container autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.container autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.container autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.container autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [self buildHeader];
    [self buildDescriptionContainer];
    [self buildPositiveActionTitle];
    [self buildTitleUnderline];
    [self buildPositiveActionDescription];
    [self buildOverTittle];
    [self buildRedBand];
}

- (void)buildHeader
{
    self.mainHeaderView = [[UIImageView alloc] initForAutoLayout];
    [self.mainHeaderView setContentMode:UIViewContentModeScaleAspectFill];
    [self.mainHeaderView setImage: [UIImage imageNamed:BACKGROUND]];
    
    [self.container addSubview:self.mainHeaderView];
    [self.mainHeaderView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
}

- (void)buildOverTittle
{
    self.overTitleView = [[UIView alloc] initForAutoLayout];
    [self.container addSubview: self.overTitleView];
    self.overTitleView.layer.cornerRadius = 10;
    self.overTitleView.clipsToBounds = YES;
    static CGFloat height = 32;
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [self.overTitleView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mainHeaderView withOffset:height/2];
    
    self.overTitleTextView = [[UITextView alloc] initForAutoLayout];
    self.overTitleTextView.scrollEnabled = NO;
    self.overTitleTextView.editable = NO;
    [self.overTitleView addSubview: self.overTitleTextView];
    [self.overTitleTextView autoPinEdgesToSuperviewEdges];
    self.overTitleTextView.text = @"Oh shit";
}

- (void)buildDescriptionContainer
{
    self.descriptionContainer = [[UIView alloc] initForAutoLayout];
    [self.container addSubview:self.descriptionContainer];
    [self.descriptionContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainHeaderView];
    [self.descriptionContainer autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UITextView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview: self.positiveActionTitle];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    self.positiveActionTitle.scrollEnabled = NO;
    self.positiveActionTitle.editable = NO;
    
    // TODO MOCK TEXT
    self.positiveActionTitle.text = @"Sumate a nuestra campaña \"NO SELFIE\"";
}

- (void)buildTitleUnderline
{
    self.colorBandImageView = [[UIImageView alloc] initForAutoLayout];
    UIImage *colorBand = [UIImage imageNamed:@"color_band"];
    [self.colorBandImageView setImage: colorBand];
    
    [self.container addSubview: self.colorBandImageView];
    [self.colorBandImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.positiveActionTitle withOffset:0];
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

- (void)buildRedBand
{
    self.redBand = [[UIView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview:self.redBand];
    
    [self.redBand autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.colorBandImageView];
    [self.redBand autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.colorBandImageView];
    
    [self.redBand autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.positiveActionDescription withOffset:8];
    [self.redBand autoAlignAxis:ALAxisVertical toSameAxisOfView:self.colorBandImageView];
}


- (void)styleSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self.overTitleView setBackgroundColor: [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed]];
    [self.overTitleTextView setTextColor: [UIColor whiteColor]];
    [self.overTitleTextView setBackgroundColor:[UIColor clearColor]];
    [self.overTitleTextView setTextAlignment: NSTextAlignmentCenter];
    [self.overTitleTextView setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                     withSize:BeautyCenterTypographySizeB]];
    
    [self.positiveActionTitle setTextColor:[UIColor blackColor]];
    [self.positiveActionTitle setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionTitle setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                     withSize:BeautyCenterTypographySizeA]];
    [self.descriptionContainer setBackgroundColor:[UIColor whiteColor]];
    
    [self.positiveActionDescription setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionDescription setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                           withSize:BeautyCenterTypographySizeA]];
    [self.redBand setBackgroundColor: [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed]];
}

@end
