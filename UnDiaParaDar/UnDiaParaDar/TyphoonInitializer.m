//
//  TyphoonInitializer.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Typhoon.h>

#import "TyphoonInitializer.h"
#import "LoginModuleAssembly.h"
#import "RoutingModuleAssembly.h"

@implementation TyphoonInitializer

+ (void)setup
{
    TyphoonComponentFactory* factory = [[TyphoonBlockComponentFactory alloc]
                                        initWithAssemblies:@[[RoutingModuleAssembly assembly],
                                                             [LoginModuleAssembly assembly],
                                                             ]];
    
    TyphoonConfigPostProcessor* configurer = [TyphoonConfigPostProcessor postProcessor];
    [configurer useResourceWithName:@("Info.plist")];
    [factory attachPostProcessor:configurer];
    [factory makeDefault];
    [factory inject:self];
}


@end
