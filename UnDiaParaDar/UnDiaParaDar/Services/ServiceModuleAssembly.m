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

#import "TyphoonConfigPostProcessor.h"

@implementation ServiceModuleAssembly

- (TopicService*)topicService
{
    SEL selector = @selector(initWithRestkitService:);
    return [TyphoonDefinition withClass:[TopicService class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self restkitService]];
        }];
    }];
}

- (UserService*)userService
{
    return [TyphoonDefinition withClass:[UserService class]];
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

@end
