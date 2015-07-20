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

@implementation TyphoonInitializer

+ (void)setup
{
    TyphoonComponentFactory* factory = [[TyphoonBlockComponentFactory alloc]
                                        initWithAssemblies:@[[LoginModuleAssembly assembly],
                                                             ]];
    
    TyphoonConfigPostProcessor* configurer = [TyphoonConfigPostProcessor postProcessor];
    [configurer useResourceWithName:@("Info.plist")];
    [factory attachPostProcessor:configurer];
    [factory makeDefault];
    [factory inject:self];
}


@end
