//
//  NetworkReachabilityAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"

@class NetworkReachabilityController, NetworkViewController;

@interface NetworkReachabilityAssembly : TyphoonAssembly

- (NetworkReachabilityController*)networkReachability;
- (NetworkViewController*)networkViewController;

@end
