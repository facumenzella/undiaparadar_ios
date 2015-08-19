//
//  UDPDRouting.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Routing.h"

@protocol Director;
@protocol Architect;
@class LoginModuleAssembly;
@class ProfileModuleAssembly;
@class SplashModuleAssembly;
@class TopicsModuleAssembly;

@interface UDPDRouting : NSObject<Routing>

- (instancetype)initWithDirector:(id<Director>)director
         withLoginModuleAssembly:(LoginModuleAssembly*)loginModuleAssembly
       withProfileModuleAssembly:(ProfileModuleAssembly*)profileModuleAssembly
        withSplashModuleAssembly:(SplashModuleAssembly*)splashModuleAssembly
        withTopicsModuleAssembly:(TopicsModuleAssembly*)topicsModuleAssembly
                   withArchitect:(id<Architect>)architect;

@end
