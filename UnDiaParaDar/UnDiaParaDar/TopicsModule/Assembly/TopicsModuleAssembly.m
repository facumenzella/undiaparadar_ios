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
#import "PositiveActionsMapViewController.h"
#import "PositiveActionViewController.h"

@interface TopicsModuleAssembly ()

@property (nonatomic, strong) RoutingModuleAssembly *routingModuleAssembly;
@property (nonatomic, strong) ServiceModuleAssembly *serviceModuleAssembly;

@end

@implementation TopicsModuleAssembly

- (TopicsCollectionViewController*)topicsCollectionViewController
{
    SEL selector = @selector(initWithRouting:withTopicsService:withTopicsSelectionDelegate:);
    return [TyphoonDefinition withClass:[TopicsCollectionViewController class]
                          configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: [self.routingModuleAssembly routing]];
            [initializer injectParameterWith: [self.serviceModuleAssembly topicService]];
            [initializer injectParameterWith: [self.routingModuleAssembly iphoneTailor]];
        }];
    }];

}

- (PositiveActionsMapViewController*)positiveActionsMapViewControllerWithTopics:(NSArray*)topics
{
    SEL selector = @selector(initWithRouting:withTopicService:withTopics:);
    return [TyphoonDefinition withClass:[PositiveActionsMapViewController class]
                          configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.routingModuleAssembly routing]];
            [initializer injectParameterWith:[self.serviceModuleAssembly topicService]];
            [initializer injectParameterWith:topics];
        }];
    }];

}

- (PositiveActionViewController*)positiveActionViewControllerWithPositiveAction:(PositiveAction*)positiveAction
{
    SEL selector = @selector(initWithPositiveAction:withRouting:);
    return [TyphoonDefinition withClass:[PositiveActionViewController class]
                          configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:positiveAction];
            [initializer injectParameterWith:[self.routingModuleAssembly routing]];
        }];
    }];

}

@end
