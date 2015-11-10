//
//  PositiveActionView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionView.h"
#import "positiveActionPresenter.h"
#import "BeautyCenter.h"
#import "ButtonFactory.h"

#import <PureLayout/PureLayout.h>

static NSString * const kPledge = @"pledge";
static NSString * const kShare = @"share";
static NSString * const BACKGROUND = @"menu_header";

@interface PositiveActionView ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *mainHeaderView;
@property (nonatomic, strong) UIImageView *topicImageView;

@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UILabel *overTitleLabel;

@property (nonatomic, strong) UIView *buttonsContainer;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *pledgeButton;

@property (nonatomic, strong) UIView *descriptionContainer;
@property (nonatomic, strong) UILabel *positiveActionTitleLabel;
@property (nonatomic, strong) UIImageView *colorBandImageView;
@property (nonatomic, strong) UITextView *positiveActionDescription;
@property (nonatomic, strong) UIView *redBand;

@property (nonatomic, strong) UIView *additionalLocationView;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIView *additionalURLView;
@property (nonatomic, strong) UITextView *externalURLLabel;

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

- (void)populateWithPositiveAction:(id<PositiveActionPresenter>)positiveAction withTopicImage:(NSString*)topicImage
{
    self.overTitleLabel.text = positiveAction.paTitle;
    self.positiveActionTitleLabel.text = positiveAction.paSubtitle;
    self.positiveActionDescription.text = positiveAction.paDescription;
    [self.topicImageView setImage:[UIImage imageNamed:topicImage]];
    
    [self.locationLabel setText:[NSString stringWithFormat:@"%@, %@", positiveAction.paCity, positiveAction.paCountry]];
    self.additionalLocationView.hidden = !positiveAction.paCity && !positiveAction.paCountry;
    
    [self.externalURLLabel setText:positiveAction.paExternalURL];
    self.additionalURLView.hidden = !positiveAction.paExternalURL;
    self.shareButton.enabled = !self.additionalURLView.hidden;
    
    // TODO add proper message
    self.pledgeButton.enabled = NO;
}

- (void)buildSubviews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initForAutoLayout];
    scrollView.scrollEnabled = YES;
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
    [self buildOverTittle];
    [self buildDescriptionContainer];
    [self buildButtons];
    [self buildPositiveActionTitle];
    [self buildTitleUnderline];
    [self buildPositiveActionDescription];
    [self buildRedBand];
    [self buildLocation];
    [self buildExternalURL];
    
    [self.container bringSubviewToFront:self.overTitleView];
}

- (void)buildHeader
{
    self.mainHeaderView = [[UIImageView alloc] initForAutoLayout];
    [self.mainHeaderView setContentMode:UIViewContentModeScaleAspectFill];
    [self.mainHeaderView setImage: [UIImage imageNamed:BACKGROUND]];
    
    [self.container addSubview:self.mainHeaderView];
    [self.mainHeaderView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    
    [self buildTopicImage];
}

- (void)buildTopicImage
{
    self.topicImageView = [[UIImageView alloc] initForAutoLayout];
    [self.mainHeaderView addSubview:self.topicImageView];
    
    [self.topicImageView autoSetDimension:ALDimensionHeight toSize:70];
    [self.topicImageView autoSetDimension:ALDimensionWidth toSize:70];
    [self.topicImageView autoCenterInSuperview];
    
    self.topicImageView.layer.cornerRadius = 35;
    self.topicImageView.clipsToBounds = YES;
    self.topicImageView.layer.borderWidth = 3.0f;
    self.topicImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}


- (void)buildOverTittle
{
    self.overTitleView = [[UIView alloc] initForAutoLayout];
    [self.container addSubview: self.overTitleView];
    self.overTitleView.layer.cornerRadius = 10;
    self.overTitleView.clipsToBounds = YES;
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [self.overTitleView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mainHeaderView withOffset:20];
    
    self.overTitleLabel = [[UILabel alloc] initForAutoLayout];
    [self.overTitleView addSubview: self.overTitleLabel];
    [self.overTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 0, 8, 0)];
    self.overTitleLabel.text = @"Oh shit";
}

- (void)buildDescriptionContainer
{
    self.descriptionContainer = [[UIView alloc] initForAutoLayout];
    [self.container addSubview:self.descriptionContainer];
    [self.descriptionContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainHeaderView];
    [self.descriptionContainer autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}

- (void)buildButtons
{
    self.buttonsContainer = [[UIView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview:self.buttonsContainer];
    [self.buttonsContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:24];
    [self.buttonsContainer autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self buildShareButton];
    [self buildPledgeButton];
}

- (void)buildShareButton
{
    self.shareButton = [ButtonFactory buttonWithImage:kShare];
    [self.buttonsContainer addSubview:self.shareButton];
    [self.shareButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    
    [self.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buildPledgeButton
{
    self.pledgeButton = [ButtonFactory buttonWithImage:kPledge];
    [self.buttonsContainer addSubview:self.pledgeButton];
    [self.pledgeButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [self.pledgeButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.shareButton withOffset:48];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitleLabel = [[UILabel alloc] initForAutoLayout];
    [self.descriptionContainer addSubview: self.positiveActionTitleLabel];
    [self.positiveActionTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.buttonsContainer withOffset:8];
    [self.positiveActionTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
}

- (void)buildTitleUnderline
{
    self.colorBandImageView = [[UIImageView alloc] initForAutoLayout];
    UIImage *colorBand = [UIImage imageNamed:@"color_band"];
    [self.colorBandImageView setImage: colorBand];
    
    [self.descriptionContainer addSubview: self.colorBandImageView];
    [self.colorBandImageView autoPinEdge:ALEdgeTop
                                  toEdge:ALEdgeBottom
                                  ofView:self.positiveActionTitleLabel
                              withOffset:8];
    [self.colorBandImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.colorBandImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.colorBandImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [self.colorBandImageView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                             forAxis:UILayoutConstraintAxisVertical];
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
    self.positiveActionDescription.scrollEnabled = NO;
    self.positiveActionDescription.editable = NO;
}

- (void)buildRedBand
{
    self.redBand = [[UIView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview:self.redBand];
    
    [self.redBand autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.colorBandImageView];
    [self.redBand autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.overTitleView];
    
    [self.redBand autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.positiveActionDescription withOffset:8];
    [self.redBand autoAlignAxis:ALAxisVertical toSameAxisOfView:self.colorBandImageView];
}

- (void)buildAdditionalInformationInsideContainer:(UIView*)container
                                        withImage:(NSString*)image
                                     withTextView:(UIView*)textView
{
    UIImageView *locationImageView = [[UIImageView alloc] initForAutoLayout];
    [locationImageView setImage:[UIImage imageNamed:image]];
    [container addSubview:locationImageView];
    [locationImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:32];
    [locationImageView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisHorizontal];
    [locationImageView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisVertical];
    [container addSubview:textView];
    [textView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:locationImageView withOffset:8];
    [textView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:locationImageView withOffset:8];
    [textView autoSetDimension:ALDimensionWidth toSize:180 relation:NSLayoutRelationLessThanOrEqual];
    [textView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [textView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [locationImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:textView];
}

- (void)buildLocation
{
    self.additionalLocationView = [[UIView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview:self.additionalLocationView];
    [self.additionalLocationView autoPinEdge:ALEdgeTop
                                      toEdge:ALEdgeBottom
                                      ofView:self.redBand
                                  withOffset:16];
    [self.additionalLocationView autoMatchDimension:ALDimensionWidth
                                        toDimension:ALDimensionWidth
                                             ofView:self.overTitleView];
    [self.additionalLocationView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.overTitleView];
    self.locationLabel = [[UILabel alloc] initForAutoLayout];
    [self buildAdditionalInformationInsideContainer:self.additionalLocationView
                                          withImage:@"location"
                                       withTextView:self.locationLabel];
}

- (void)buildExternalURL
{
    self.additionalURLView = [[UIView alloc] initForAutoLayout];
    [self.descriptionContainer addSubview:self.additionalURLView];
    [self.additionalURLView autoPinEdge:ALEdgeTop
                                 toEdge:ALEdgeBottom
                                 ofView:self.additionalLocationView
                             withOffset:8];
    [self.additionalURLView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [self.additionalURLView autoMatchDimension:ALDimensionWidth
                                   toDimension:ALDimensionWidth
                                        ofView:self.overTitleView];
    [self.additionalURLView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.overTitleView];
    self.externalURLLabel = [[UITextView alloc] initForAutoLayout];
    [self buildAdditionalInformationInsideContainer:self.additionalURLView
                                          withImage:@"external"
                                       withTextView:self.externalURLLabel];
}

- (void)styleSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self.overTitleView setBackgroundColor: [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed]];
    self.overTitleLabel.numberOfLines = 3;
    self.overTitleLabel.textColor = [UIColor whiteColor];
    self.overTitleLabel.backgroundColor = [UIColor clearColor];
    self.overTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.overTitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                              withSize:BeautyCenterTypographySizeB];
    
    self.positiveActionTitleLabel.textColor = [UIColor blackColor];
    self.positiveActionTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.positiveActionTitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                        withSize:BeautyCenterTypographySizeA];
    self.positiveActionTitleLabel.numberOfLines = 4;
    
    [self.descriptionContainer setBackgroundColor:[UIColor whiteColor]];
    
    [self.positiveActionDescription setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionDescription setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                           withSize:BeautyCenterTypographySizeA]];
    self.positiveActionDescription.dataDetectorTypes = UIDataDetectorTypeAll;
    
    
    [self styleAdditionalInformation:@[self.locationLabel, self.externalURLLabel]];
    [self styleURL];
    [self.redBand setBackgroundColor: [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed]];
}

- (void)styleAdditionalInformation:(NSArray*)additionalInfo
{
    for (UILabel *t in additionalInfo) {
        [t setTextAlignment:NSTextAlignmentLeft];
        [t setFont:[BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleBold
                                                  withSize:BeautyCenterTypographySizeA]];
    }
}

- (void)styleURL
{
    self.externalURLLabel.editable = NO;
    self.externalURLLabel.scrollEnabled = NO;
    self.externalURLLabel.textContainer.maximumNumberOfLines = 1;
    self.externalURLLabel.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    self.externalURLLabel.dataDetectorTypes = UIDataDetectorTypeAll;
}

#pragma mark - PositiveActionViewDelegate

- (void)share
{
    [self.delegate share];
}

@end
