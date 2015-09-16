//
//  MapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsWithMapViewController.h"
#import "Routing.h"

@interface PositiveActionsWithMapViewController ()

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

@end
