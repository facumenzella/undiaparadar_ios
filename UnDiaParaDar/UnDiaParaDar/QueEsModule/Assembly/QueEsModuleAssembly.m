//
//  QueEsModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "QueEsModuleAssembly.h"
#import "QueEsViewController.h"

#import "TyphoonConfigPostProcessor.h"

@implementation QueEsModuleAssembly

- (QueEsViewController*)queEsViewController
{
    NSString *path = TyphoonConfig(@"queEsUdpd");
    SEL selector = @selector(initWithQueEsPath:);
    return [TyphoonDefinition withClass:[QueEsViewController class] configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: path];
        }];
    }];
}

@end
