
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

@end

@implementation MenuModuleAssembly

- (MenuViewController*) menuViewController
{
    
    SEL selector = @selector(initWithRouting:);
    return [TyphoonDefinition withClass:[MenuViewController class] configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: [self.routingModuleAssembly routing]];
        }];
    }];

}


@end
