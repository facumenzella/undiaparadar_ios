//
//  MapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsWithMapViewController.h"

#import "Routing.h"
#import <MapKit/MapKit.h>
#import <UIView+AutoLayout.h>

@interface PositiveActionsWithMapViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) id<Routing> routing;

@end

@implementation PositiveActionsWithMapViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.mapView = [[MKMapView alloc] initForAutoLayout];
    [self.view addSubview:self.mapView];
    
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_mapView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

@end
