//
//  MapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapViewController.h"
#import "PositiveActionsWithMapView.h"

#import "Routing.h"

@interface PositiveActionsMapViewController ()

@property (strong, nonatomic) id<Routing> routing;

@property (nonatomic, strong) PositiveActionsWithMapView *positiveActionsView;

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
    self.positiveActionsView = [[PositiveActionsWithMapView alloc] init];
    self.view = self.positiveActionsView;
}

- (void)viewDidLoad
{

}

@end
