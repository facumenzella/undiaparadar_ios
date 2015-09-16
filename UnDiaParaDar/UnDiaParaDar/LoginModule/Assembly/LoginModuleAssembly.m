//
//  LoginModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoginModuleAssembly.h"
#import "RoutingModuleAssembly.h"

#import "LoginViewController.h"

@interface LoginModuleAssembly ()

@property (nonatomic, strong) RoutingModuleAssembly *routingModuleAssembly;

@end

@implementation LoginModuleAssembly

#pragma mark - LoginModuleAssembly

- (LoginViewController*)loginViewController
{
    SEL selector = @selector(initWithRouting:);
    id<Routing> routing = [self.routingModuleAssembly routing];
    return [TyphoonDefinition withClass:[LoginViewController class] configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: routing];
        }];
    }];
}


@end
