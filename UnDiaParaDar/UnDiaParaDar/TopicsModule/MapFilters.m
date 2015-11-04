//
//  MapFilters.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MapFilters.h"

static NSUInteger const kDefaultRadius = 1000;
static BOOL const kDefaultRadiusEnabled = YES;

@implementation MapFilters

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.radius = kDefaultRadius;
        self.radioEnabled = kDefaultRadiusEnabled;
    }
    return self;
}

@end
