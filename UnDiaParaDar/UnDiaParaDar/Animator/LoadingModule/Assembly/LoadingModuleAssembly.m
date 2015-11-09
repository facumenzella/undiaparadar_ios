//
//  LoadingModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoadingModuleAssembly.h"

@implementation LoadingModuleAssembly

- (LoadingViewController*)loadingViewControllerWithLoadingBlock:(LoadingBlock)loadingBlock
{
    SEL selector = @selector(initWithLoadingBlock:);
    return [TyphoonDefinition withClass:[LoadingViewController class] configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:loadingBlock];
        }];
    }];
}

@end
