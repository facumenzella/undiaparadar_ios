//
//  PositiveActionsWithMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsWithMapView.h"
#import "PositiveActionDetailView.h"
#import "ButtonFactory.h"

#import <MapKit/MapKit.h>
#import <PureLayout/PureLayout.h>

@interface PositiveActionsWithMapView ()

@property (nonatomic) PositiveActionsWithMapViewState state;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UILabel *overTitleLabel;
@property (nonatomic, strong) PositiveActionDetailView *detailView;

@property (nonatomic) CGFloat mapActiveHeight;
@property (nonatomic) CGFloat mapInactiveHeight;
@property (nonatomic, strong) NSLayoutConstraint *mapHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *mapTap;
@property (nonatomic, strong) UITapGestureRecognizer *detailTap;

@property (nonatomic, strong) NSArray *mapActiveConstraints;
@property (nonatomic, strong) NSArray *detailActiveConstraints;

@end

@implementation PositiveActionsWithMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        self.state = PositiveActionsWithMapViewStateDescription;
        [self initializeHeights];
        [self buildSubviews];
        [self buildButtons];
        [self updateUIState];
    }
    return self;
}

- (void)initializeHeights
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    self.mapActiveHeight = 3 * screenHeight / 4;
    self.mapInactiveHeight = 3 * screenHeight / 8;
}

- (void)buildSubviews
{
    [self buildMapView];
    [self buildDetailView];
    [self buildOverTittle];
}

- (void)buildMapView
{
    self.mapView = [[MKMapView alloc] initForAutoLayout];
    [self addSubview: self.mapView];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    CGFloat height = (self.state == PositiveActionsWithMapViewStateMap) ? self.mapActiveHeight : self.mapInactiveHeight;
    self.mapHeightConstraint = [self.mapView autoSetDimension:ALDimensionHeight
                                                       toSize:height];
    
    self.mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchToMapActiveState)];
    [self.mapView addGestureRecognizer:self.mapTap];
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
    self.mapActiveConstraints = [NSLayoutConstraint autoCreateConstraintsWithoutInstalling:^{
        [shareButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:32];
        [pledgeButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:-32];

        [shareButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-16];
        [pledgeButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-16];
    }];
    self.detailActiveConstraints = [NSLayoutConstraint autoCreateConstraintsWithoutInstalling:^{
        [pledgeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
        [shareButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pledgeButton withOffset:16];
        
        [shareButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-8];
        [shareButton autoAlignAxis:ALAxisVertical toSameAxisOfView:pledgeButton];
    }];
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
    self.detailTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(switchToDescriptionActiveState)];
    [self.detailView addGestureRecognizer:self.detailTap];
    [self.detailView setState:self.state];
}

- (void)styleSubviews
{
    switch (self.state) {
        case PositiveActionsWithMapViewStateMap:
            [self styleSubviewsViewStateMap];
            break;
        case PositiveActionsWithMapViewStateDescription:
            [self styleSubviewsViewStateDescription];
            break;
        default:
            NSLog(@"Holy shit, weird state in POSITIVEACTIONSVIEW");
            break;
    }
    [self.detailView setState:self.state];
}

#pragma mark - Style

- (void)styleSubviewsViewStateDescription
{
    [self.overTitleView setBackgroundColor: [UIColor whiteColor]];
    
    [self.overTitleLabel setTextColor: [UIColor blackColor]];
    [self.overTitleLabel setTextAlignment: NSTextAlignmentCenter];
}

- (void)styleSubviewsViewStateMap
{
    [self.overTitleView setBackgroundColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
    
    [self.overTitleLabel setTextColor: [UIColor whiteColor]];
    [self.overTitleLabel setTextAlignment: NSTextAlignmentCenter];
}

#pragma mark - UpdateConstraints

- (void)switchToMapActiveState
{
    self.state = PositiveActionsWithMapViewStateMap;
    self.mapHeightConstraint.constant = self.mapActiveHeight;
    [self animateSwitchingStates];
}

- (void)switchToDescriptionActiveState
{
    self.state = PositiveActionsWithMapViewStateDescription;
    self.mapHeightConstraint.constant = self.mapInactiveHeight;
    [self animateSwitchingStates];
}

- (void)updateUIState
{
    [self styleSubviews];
    [self updateButtons];
    [self updateTapGestureRecognizers];
}

- (void)updateButtons
{
    if (self.state == PositiveActionsWithMapViewStateMap) {
        [self.mapActiveConstraints autoInstallConstraints];
        [self.detailActiveConstraints autoRemoveConstraints];
    } else {
        [self.mapActiveConstraints autoRemoveConstraints];
        [self.detailActiveConstraints autoInstallConstraints];
    }
}

- (void)updateTapGestureRecognizers
{
    self.mapView.scrollEnabled = self.state == PositiveActionsWithMapViewStateMap;
    // enable / disable taps to activate each section
    self.mapTap.enabled = self.state == PositiveActionsWithMapViewStateDescription;
    self.detailTap.enabled = !self.mapTap.enabled;
}

#pragma mark - Animations

- (void)animateSwitchingStates
{
    [UIView animateWithDuration:1 animations:^{
        [self updateUIState];
        [self layoutIfNeeded];
    }];
}



@end
