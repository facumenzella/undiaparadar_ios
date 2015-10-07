//
//  ProfileModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ProfileModuleAssembly.h"
#import "ProfileViewController.h"
#import "RoutingModuleAssembly.h"
#import "ServiceModuleAssembly.h"

@interface ProfileModuleAssembly ()

@property (nonatomic, strong) RoutingModuleAssembly *routingModuleAssembly;
@property (nonatomic, strong) ServiceModuleAssembly *serviceModuleAssembly;

@end

@implementation ProfileModuleAssembly

#pragma mark - ProfileModuleAssembly

- (ProfileViewController*)profileViewController
{
    SEL selector = @selector(initWithRouting:withUserService:);
    return [TyphoonDefinition withClass:[ProfileViewController class] configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.routingModuleAssembly routing]];
            [initializer injectParameterWith:[self.serviceModuleAssembly userService]];
        }];
    }];
}

@end
