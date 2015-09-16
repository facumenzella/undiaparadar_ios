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

@interface PositiveActionsWithMapView ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UIView *detailView;

@property (nonatomic) CGFloat mapActiveHeight;
@property (nonatomic) CGFloat mapInactiveHeight;
@property (nonatomic, strong) NSLayoutConstraint *mapHeightConstraint;

@end

@implementation PositiveActionsWithMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeHeights];
        [self buildSubviews];
    }
    return self;
}

- (void)initializeHeights
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    self.mapActiveHeight = 3 * screenHeight / 4;
}

- (void)buildSubviews
{
    [self buildMapView];
    [self buildDetailView];
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
}

- (void)buildOverTittle
{
    self.overTitleView = [[UIView alloc] initForAutoLayout];
    
}

- (void)buildDetailView
{
    self.detailView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.detailView];
    [self addSubview: self.mapView];
    [self.detailView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.detailView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.detailView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}
@end
