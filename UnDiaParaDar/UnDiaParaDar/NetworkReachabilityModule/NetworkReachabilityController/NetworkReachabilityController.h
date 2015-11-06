//
//  NetworkReachabilityController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Routing;

@interface NetworkReachabilityController : NSObject

- (instancetype)initWithRouting:(id<Routing>)routing;
- (void)setup;

@end
