//
//  SpotifyLikeViewPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotifyLikeViewPresenter : NSObject

@property (nonatomic, strong) UIImage *profileUserImage;
@property (nonatomic, strong) UIImage *profileTimelineImage;

-(instancetype)initWithProfilePicture:(NSString*)userProfilePicture withTimelinePicture:(NSString*)timelinePicture;

@end
