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
#import "LoginViewController.h"

@interface UDPDRouting ()

@property (nonatomic, strong) id<Director> director;

@property (nonatomic, strong) LoginModuleAssembly *loginModuleAssembly;

@end

@implementation UDPDRouting

- (instancetype)initWithDirector:(id<Director>)director
         withLoginModuleAssembly:(LoginModuleAssembly*)loginModuleAssembly
{
    self = [super init];
    if (self) {
        self.director = director;
        self.loginModuleAssembly = loginModuleAssembly;
    }
    return self;
}

- (void)showLoginPage
{
    // This warning occurs because of foward declaration, we will take care of it later
    [self.director setRoot:[self.loginModuleAssembly loginViewController]];
}

- (void)showMainPage
{
    // TODO not done yet
}

@end
