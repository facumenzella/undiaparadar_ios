//
//  ProfileViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ProfileViewController.h"
#import "SpotifyLikeView.h"
#import "SpotifyLikeViewPresenter.h"
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
    SpotifyLikeViewPresenter *presenter = [[SpotifyLikeViewPresenter alloc] initWithProfilePicture:@"avatar128x128"
                                                                               withTimelinePicture:@"timeline"];
    self.view = [[SpotifyLikeView alloc] initWithPresenter:presenter];
}


@end
