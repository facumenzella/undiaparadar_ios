//
//  PositiveActionsWithMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsWithMapView.h"
#import <MapKit/MapKit.h>

#import <PureLayout/PureLayout.h>

typedef NS_ENUM(NSUInteger, PositiveActionsWithMapViewState) {
    PositiveActionsWithMapViewStateMap,
    PositiveActionsWithMapViewStateDescription
};

@interface PositiveActionsWithMapView ()

@property (nonatomic) PositiveActionsWithMapViewState state;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UILabel *overTitleLabel;
@property (nonatomic, strong) UIView *detailView;

@property (nonatomic) CGFloat mapActiveHeight;
@property (nonatomic) CGFloat mapInactiveHeight;
@property (nonatomic, strong) NSLayoutConstraint *mapHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *mapTap;
@property (nonatomic, strong) UITapGestureRecognizer *detailTap;

@end

@implementation PositiveActionsWithMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        self.state = PositiveActionsWithMapViewStateMap;
        [self initializeHeights];
        [self buildSubviews];
        [self styleSubviews];
        [self updateTapGestureRecognizers];
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
    self.mapHeightConstraint = [self.mapView autoSetDimension:ALDimensionHeight
                                                                      toSize:self.mapActiveHeight];
    
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
    [self.overTitleView autoSetDimension:ALDimensionHeight toSize:32];
    [self.overTitleView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mapView withOffset:height/2];
    self.overTitleView.layer.cornerRadius = 10;
    self.overTitleView.clipsToBounds = YES;
    
//    [self buildOverTitleLabel];
}

- (void)buildOverTitleLabel
{
    self.overTitleLabel = [[UILabel alloc] initForAutoLayout];
    [self.overTitleView addSubview: self.overTitleLabel];
    [self.overTitleLabel autoPinEdgesToSuperviewEdges];
    // TODO mock text
    self.overTitleLabel.text = @"Fundación Hernocentro Mar del Plata";
}

- (void)buildDetailView
{
    self.detailView = [[UIView alloc] initForAutoLayout];
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
}

#pragma mark - Style

- (void)styleSubviewsViewStateMap
{
    [self.overTitleView setBackgroundColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
   
    [self.overTitleLabel setTextColor: [UIColor whiteColor]];
    [self.overTitleLabel setTextAlignment: NSTextAlignmentCenter];
}

- (void)styleSubviewsViewStateDescription
{
    [self.overTitleView setBackgroundColor: [UIColor whiteColor]];
    
    [self.overTitleLabel setTextColor: [UIColor blackColor]];
    [self.overTitleLabel setTextAlignment: NSTextAlignmentCenter];
}

#pragma mark - UpdateConstraints

- (void)switchToMapActiveState
{
    self.state = PositiveActionsWithMapViewStateMap;
    self.mapHeightConstraint.constant = self.mapActiveHeight;
    [self updateTapGestureRecognizers];
    [self animateSwitchingStates];
}

- (void)switchToDescriptionActiveState
{
    self.state = PositiveActionsWithMapViewStateDescription;
    self.mapHeightConstraint.constant = self.mapInactiveHeight;
    [self updateTapGestureRecognizers];
    [self animateSwitchingStates];
}

- (void)updateTapGestureRecognizers
{
    BOOL mapActive = self.state == PositiveActionsWithMapViewStateMap;
    self.mapView.scrollEnabled = mapActive;
    // enable / disable taps to activate each section
    self.mapTap.enabled = !mapActive;
    self.detailTap.enabled = mapActive;
}

#pragma mark - Animations

- (void)animateSwitchingStates
{
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    }];
}



@end
