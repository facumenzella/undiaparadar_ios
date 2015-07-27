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

@interface ProfileViewController ()

@property (nonatomic, strong) id<Routing> routing;

@end

@implementation ProfileViewController

#pragma mark - ProfileViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
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
