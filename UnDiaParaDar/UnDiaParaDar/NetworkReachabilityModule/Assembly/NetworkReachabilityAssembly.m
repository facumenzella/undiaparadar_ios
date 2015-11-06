//
//  NetworkReachabilityAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "NetworkReachabilityAssembly.h"
#import "NetworkReachabilityController.h"
#import "NetworkViewController.h"
#import "RoutingModuleAssembly.h"

@interface NetworkReachabilityAssembly ()

@property (nonatomic, strong) RoutingModuleAssembly *routingAssembly;

@end

@implementation NetworkReachabilityAssembly

- (NetworkReachabilityController*)networkReachability
{
    SEL selector = @selector(initWithRouting:);
    return [TyphoonDefinition withClass:[NetworkReachabilityController class]
                          configuration:^(TyphoonDefinition* definition) {
                              definition.scope = TyphoonScopeSingleton;
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self.routingAssembly routing]];
                              }];
                          }];
}

- (NetworkViewController*)networkViewController
{
    SEL selector = @selector(initWithRouting:);
    return [TyphoonDefinition withClass:[NetworkViewController class]
                          configuration:^(TyphoonDefinition* definition) {
                              definition.scope = TyphoonScopeSingleton;
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self.routingAssembly routing]];
                              }];
                          }];
}


@end
