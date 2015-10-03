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
#import "ProfileModuleAssembly.h"
#import "AppDelegateAssembly.h"
#import "MenuModuleAssembly.h"
#import "SplashModuleAssembly.h"
#import "TopicsModuleAssembly.h"
#import "ServiceModuleAssembly.h"
#import "TermsAndConditionsAssembly.h"
#import "QueEsModuleAssembly.h"
#import "LoadingModuleAssembly.h"

@implementation TyphoonInitializer

+ (void)setup
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    TyphoonComponentFactory* factory = [[TyphoonBlockComponentFactory alloc]
                                        initWithAssemblies:@[[RoutingModuleAssembly assembly],
                                                             [AppDelegateAssembly assembly],
                                                             [LoginModuleAssembly assembly],
                                                             [ProfileModuleAssembly assembly],
                                                             [MenuModuleAssembly assembly],
                                                             [SplashModuleAssembly assembly],
                                                             [TopicsModuleAssembly assembly],
                                                             [ServiceModuleAssembly assembly],
                                                             [TermsAndConditionsAssembly assembly],
                                                             [QueEsModuleAssembly assembly],
                                                             [LoadingModuleAssembly assembly]
                                                             ]];
    
    TyphoonConfigPostProcessor* configurer = [TyphoonConfigPostProcessor postProcessor];
    [configurer useResourceWithName:@("env.plist")];
    [factory attachPostProcessor:configurer];
    [factory makeDefault];
    [factory inject:appDelegate];
}


@end
