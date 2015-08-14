//
//  SplashModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SplashModuleAssembly.h"
#import "SplashViewController.h"

@implementation SplashModuleAssembly

#pragma mark - SplashModuleAssembly

- (SplashViewController*)splashViewController
{
    return [TyphoonDefinition withClass:[SplashViewController class]];
}

@end
