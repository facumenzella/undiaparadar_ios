//
//  ProfileViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ProfileViewController.h"
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
    // TODO not done yet
}


@end
