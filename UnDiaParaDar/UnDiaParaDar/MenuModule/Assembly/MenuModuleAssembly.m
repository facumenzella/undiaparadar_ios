
//
//  MenuModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuModuleAssembly.h"
#import "RoutingModuleAssembly.h"
#import "ServiceModuleAssembly.h"
#import "MenuViewController.h"

@interface MenuModuleAssembly ()

@property (nonatomic, strong) RoutingModuleAssembly *routingModuleAssembly;
@property (nonatomic, strong) ServiceModuleAssembly *serviceModuleAssembly;

@end

@implementation MenuModuleAssembly

- (MenuViewController*) menuViewController
{
    
    SEL selector = @selector(initWithRouting:withUserService:);
    return [TyphoonDefinition withClass:[MenuViewController class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: [self.routingModuleAssembly routing]];
            [initializer injectParameterWith: [self.serviceModuleAssembly userService]];
        }];
    }];

}


@end
