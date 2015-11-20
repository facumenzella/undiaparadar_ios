//
//  MapFilters.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MapFilters.h"

static NSUInteger const kDefaultRadio = 1000;
static BOOL const kDefaultRadiusEnabled = YES;

@implementation MapFilters

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.radio = kDefaultRadio;
        self.radioEnabled = kDefaultRadiusEnabled;
    }
    return self;
}

- (instancetype)initWithSelectedTopics:(NSArray*)topics
           withLocationServicesEnabled:(BOOL)enabled
{
    self = [super init];
    if (self) {
        self.locationEnabled = enabled;
        self.selectedTopics = topics;
    }
    return self;
}


- (instancetype)initWithSelectedTopics:(NSArray*)topics
{
    return [self initWithSelectedTopics:topics withLocationServicesEnabled:YES];
}

@end
