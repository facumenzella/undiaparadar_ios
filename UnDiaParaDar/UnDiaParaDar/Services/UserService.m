//
//  UserService.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/11/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "UserService.h"
#import "User.h"
#import <FBSDKProfile.h>

@implementation UserService

- (void)userWithCallback:(void (^)(User*))callback
{
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    User *u = [[User alloc] init];
    u.name = profile.name;
    
    callback(u);
}

- (void)userProfilePictureWithCGSize:(CGSize)size withCallback:(void (^)(NSString*))callback
{
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    NSString *image = [profile imagePathForPictureMode:FBSDKProfilePictureModeNormal size:size];
    callback(image);
}


@end
