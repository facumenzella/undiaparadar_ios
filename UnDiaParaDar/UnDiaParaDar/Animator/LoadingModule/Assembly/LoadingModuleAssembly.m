//
//  LoadingModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoadingModuleAssembly.h"
#import "LoadingViewController.h"

@implementation LoadingModuleAssembly

- (LoadingViewController*)loadingViewController
{
    SEL selector = @selector(init);
    return [TyphoonDefinition withClass:[LoadingViewController class] configuration:^(TyphoonDefinition* definition) {
        definition.scope = TyphoonScopeSingleton;
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
        }];
    }];
}

@end
