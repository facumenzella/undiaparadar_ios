//
//  PositiveActionsMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapView.h"
#import "ButtonFactory.h"

#import <MapKit/MapKit.h>
#import <PureLayout/PureLayout.h>

@interface PositiveActionsMapView ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UILabel *overTitleLabel;

@property (nonatomic) CGFloat mapHeight;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITextView *positiveActionTitle;
@property (nonatomic, strong) UIImageView *colorBandImageView;

@end

@implementation PositiveActionsMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        [self setupHeight];
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)setupHeight
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    self.mapHeight = (3 * screenHeight / 4);
}

- (void)buildSubviews
{
    [self buildMapView];
    [self buildFooterView];
    [self buildOverTittle];
    [self buildButtons];
}

- (void)buildMapView
{
    self.mapView = [[MKMapView alloc] initForAutoLayout];
    [self addSubview: self.mapView];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.mapView autoSetDimension:ALDimensionHeight toSize:self.mapHeight];
}

- (void)buildOverTittle
{
    self.overTitleView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.overTitleView];
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    static CGFloat height = 32;
    [self.overTitleView autoSetDimension:ALDimensionHeight toSize:height];
    [self.overTitleView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mapView withOffset:height/2];
    self.overTitleView.layer.cornerRadius = 10;
    self.overTitleView.clipsToBounds = YES;
    
    [self buildOverTitleLabel];
}

- (void)buildOverTitleLabel
{
    self.overTitleLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview: self.overTitleLabel];
    [self.overTitleLabel autoSetDimension:ALDimensionHeight toSize:32];
    [self.overTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.overTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [self.overTitleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mapView withOffset:16];
    // TODO mock text
    self.overTitleLabel.text = @"Fuck iOS";
}

- (void)buildButtons
{
    UIButton *shareButton = [ButtonFactory buttonWithImage:@"share"];
    UIButton *pledgeButton = [ButtonFactory buttonWithImage:@"pledge"];
    
    [self addSubview:shareButton];
    [self addSubview:pledgeButton];
    [shareButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:32];
    [pledgeButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:-32];
    
    [shareButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-16];
    [pledgeButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-16];
}

- (void)buildFooterView
{
    self.footerView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.footerView];
    
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.footerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapView];
    
    [self buildPositiveActionTitle];
    [self buildTitleUnderline];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UITextView alloc] initForAutoLayout];
    self.positiveActionTitle.scrollEnabled = NO;
    [self.footerView addSubview: self.positiveActionTitle];
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
    
    [self.footerView addSubview: self.colorBandImageView];
    [self.colorBandImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView: self.positiveActionTitle withOffset:8];
    [self.colorBandImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.colorBandImageView autoMatchDimension:ALDimensionWidth
                                    toDimension:ALDimensionWidth
                                         ofView:self.positiveActionTitle];
}


#pragma mark - Style

- (void)styleSubviews
{
    [self.overTitleView setBackgroundColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
    
    [self.overTitleLabel setTextColor: [UIColor whiteColor]];
    [self.overTitleLabel setTextAlignment: NSTextAlignmentCenter];

    [self.footerView setBackgroundColor: [UIColor whiteColor]];
    
    [self.positiveActionTitle setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionTitle setTextColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
}


@end
