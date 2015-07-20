//
//  UDPDRouting.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "UDPDRouting.h"
#import "Director.h"
#import "LoginModuleAssembly.h"

@interface UDPDRouting ()

@property (nonatomic, strong) LoginModuleAssembly *loginModuleAssembly;

@property (nonatomic, strong) id<Director> director;

@end

@implementation UDPDRouting

- (void)showLoginPage
{
    // This warning occurs because of foward declaration, we will take care of it later
    [self.director setRoot:[self.loginModuleAssembly loginViewController]];
}

@end
