//
//  MapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapViewController.h"
#import "PositiveActionsMapView.h"

#import "Routing.h"

@interface PositiveActionsMapViewController () <PositiveActionsMapViewDelegate>

@property (strong, nonatomic) id<Routing> routing;

@property (nonatomic, strong) PositiveActionsMapView *positiveActionsView;

@end

@implementation PositiveActionsMapViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

-(void)loadView
{
    self.positiveActionsView = [[PositiveActionsMapView alloc] init];
    self.view = self.positiveActionsView;
}

- (void)viewDidLoad
{
    
}

#pragma mark - PositiveActionsMapViewDelegate

-(void)didSelectShareButton
{
    // TODO
}

-(void)didSelectPledgeButton
{
    // TODO
}

-(void)didSelectDetail
{
    // TODO
}

@end
