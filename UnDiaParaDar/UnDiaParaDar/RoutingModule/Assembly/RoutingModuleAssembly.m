//
//  RoutingModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "RoutingModuleAssembly.h"
#import "SWRevealDirector.h"
#import "UDPDRouting.h"

@implementation RoutingModuleAssembly

- (id<Routing>) routing
{
    SEL selector = @selector(init);
    return [TyphoonDefinition withClass:[UDPDRouting class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  // parameters soon to be added
                              }];
                          }];
}

- (id<Director>) iphoneDirector
{
    SEL selector = @selector(initWithWindow:);
    return [TyphoonDefinition withClass:[SWRevealDirector class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[UIApplication sharedApplication].keyWindow];
                              }];
                          }];
}

@end
