//
//  RoutingModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"
#import "Director.h"
#import "Routing.h"

@interface RoutingModuleAssembly : TyphoonAssembly

- (id<Director>) iphoneDirector;
- (id<Routing>) routing;

@end
