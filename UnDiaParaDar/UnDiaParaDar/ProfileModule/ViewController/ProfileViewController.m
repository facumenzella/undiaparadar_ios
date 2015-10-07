//
//  ProfileViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import "Routing.h"
#import "UserService.h"

@interface ProfileViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) UserService *userService;

@end

@implementation ProfileViewController

#pragma mark - ProfileViewController

- (instancetype)initWithRouting:(id<Routing>)routing withUserService:(UserService*)userService
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.userService = userService;
    }
    return self;
}

- (void)loadView
{
    self.view = [[ProfileView alloc] init];
}


@end
