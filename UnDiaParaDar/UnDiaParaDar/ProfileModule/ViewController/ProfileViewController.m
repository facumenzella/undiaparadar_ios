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

@property (nonatomic, strong) ProfileView *profileView;

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
    self.profileView = [[ProfileView alloc] init];
    self.view = self.profileView;
}

-(void)viewDidLoad
{
    [self.userService userWithCallback:^(User *user) {
        [self.profileView populateWithUser:user];
    }];
}


@end
