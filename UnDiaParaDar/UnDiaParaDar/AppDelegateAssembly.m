//
//  AppDelegateAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "AppDelegateAssembly.h"
#import "AppDelegate.h"

// Ignore no selector in translation unit
#pragma clang diagnostic ignored "-Wselector"
#pragma GCC diagnostic ignored "-Wundeclared-selector"

@implementation AppDelegateAssembly

- (AppDelegate*)appDelegate
{
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(routing)];
            }];
}


@end
