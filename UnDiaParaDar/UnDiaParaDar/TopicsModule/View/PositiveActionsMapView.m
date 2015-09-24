//
//  PositiveActionsMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapView.h"
#import "PositiveActionDetailView.h"
#import "ButtonFactory.h"

#import <MapKit/MapKit.h>
#import <PureLayout/PureLayout.h>

@interface PositiveActionsMapView ()

@property (nonatomic) PositiveActionsMapViewState state;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UILabel *overTitleLabel;
@property (nonatomic, strong) PositiveActionDetailView *detailView;

@property (nonatomic) CGFloat mapHeight;

@end

@implementation PositiveActionsMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        self.state = PositiveActionsMapViewStateDescription;
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
    [self buildDetailView];
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

- (void)buildDetailView
{
    self.detailView = [[PositiveActionDetailView alloc] initForAutoLayout];
    self.detailView.userInteractionEnabled = YES;
    [self addSubview: self.detailView];
    [self addSubview: self.mapView];
    [self.detailView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.detailView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.detailView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.detailView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapView];
}

#pragma mark - Style

- (void)styleSubviews
{
    [self.overTitleView setBackgroundColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
    
    [self.overTitleLabel setTextColor: [UIColor whiteColor]];
    [self.overTitleLabel setTextAlignment: NSTextAlignmentCenter];}


@end
