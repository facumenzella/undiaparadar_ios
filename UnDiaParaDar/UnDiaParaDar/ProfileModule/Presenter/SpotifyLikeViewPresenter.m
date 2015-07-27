//
//  SpotifyLikeViewPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SpotifyLikeViewPresenter.h"

@implementation SpotifyLikeViewPresenter

-(instancetype)initWithProfilePicture:(NSString*)userProfilePicture withTimelinePicture:(NSString*)timelinePicture
{
    self = [super init];
    if (self) {
        self.userProfilePicture = [UIImage imageNamed:userProfilePicture];
        self.timelineProfilePicture = [UIImage imageNamed:timelinePicture];
    }
    return self;
}

@end
