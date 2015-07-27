//
//  RoutingModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"
@protocol Director;
@protocol Routing;
@protocol Tailor;
@protocol Architect;

@interface RoutingModuleAssembly : TyphoonAssembly

- (id<Director>) iphoneDirector;
- (id<Routing>) routing;
- (id<Tailor>) iphoneTailor;
- (id<Architect>) iphoneArchitect;

@end
