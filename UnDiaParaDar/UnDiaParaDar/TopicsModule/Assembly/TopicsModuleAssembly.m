//
//  TopicsModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsModuleAssembly.h"
#import "RoutingModuleAssembly.h"
#import "ServiceModuleAssembly.h"

#import "TopicsCollectionViewController.h"

@interface TopicsModuleAssembly ()

@property (nonatomic, strong) RoutingModuleAssembly *routingModuleAssembly;
@property (nonatomic, strong) ServiceModuleAssembly *serviceModuleAssembly;

@end

@implementation TopicsModuleAssembly

- (TopicsCollectionViewController*)topicsCollectionViewController
{
    SEL selector = @selector(initWithRouting:withTopicsService:);
    id<Routing> routing = [self.routingModuleAssembly routing];
    TopicService *topicService = [self.serviceModuleAssembly topicService];
    return [TyphoonDefinition withClass:[TopicsCollectionViewController class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: routing];
            [initializer injectParameterWith: topicService];
        }];
    }];

}


@end
