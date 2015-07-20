//
//  LoginModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoginModuleAssembly.h"
#import "LoginViewController.h"

@implementation LoginModuleAssembly

#pragma mark - LoginModuleAssembly

- (LoginViewController*)loginViewController
{
    SEL selector = @selector(init);
    
    return [TyphoonDefinition withClass:[LoginViewController class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            // parameters soon to be added
        }];
    }];
}


@end
