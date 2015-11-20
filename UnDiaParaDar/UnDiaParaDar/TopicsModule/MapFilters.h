//
//  MapFilters.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapFilters : NSObject

@property (nonatomic) NSUInteger radio;
@property (nonatomic) BOOL radioEnabled;
@property (nonatomic) BOOL locationEnabled;

// remember that an empty array means all selected
@property (nonatomic) NSArray *selectedTopics;

- (instancetype)initWithSelectedTopics:(NSArray*)topics withLocationServicesEnabled:(BOOL)enabled;
- (instancetype)initWithSelectedTopics:(NSArray*)topics;

@end

@protocol MapFiltersHandler <NSObject>

- (void)handleFilters:(MapFilters*)mapFilters;

@end