//
//  ServiceModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ServiceModuleAssembly.h"

#import "TopicService.h"
#import "UserService.h"
#import "RestkitService.h"
#import "MappingProvider.h"

#import "TyphoonConfigPostProcessor.h"

@implementation ServiceModuleAssembly

- (TopicService*)topicService
{
    SEL selector = @selector(initWithRestkitService:withMappingProvider:);
    return [TyphoonDefinition withClass:[TopicService class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self restkitService]];
            [initializer injectParameterWith:[self mappingProvider]];
        }];
    }];
}

- (UserService*)userService
{
    return [TyphoonDefinition withClass:[UserService class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (RestkitService*)restkitService
{
    NSString const *baseURL = TyphoonConfig(@"baseURL");
    
    SEL selector = @selector(initWithBaseURL:);
    return [TyphoonDefinition withClass:[RestkitService class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:baseURL];
        }];
    }];
}

- (MappingProvider*)mappingProvider
{
    return [TyphoonDefinition withClass:[MappingProvider class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end
