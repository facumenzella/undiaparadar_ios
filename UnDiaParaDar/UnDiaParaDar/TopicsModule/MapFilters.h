//
//  MapFilters.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapFilters : NSObject

@property (nonatomic) NSUInteger radius;
@property (nonatomic) BOOL radioEnabled;

@property (nonatomic) NSArray *selectedTopics;

@end
