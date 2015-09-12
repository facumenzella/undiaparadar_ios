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
#import <FBSDKGraphRequest.h>

@implementation UserService

- (void)userWithCallback:(void (^)(User*))callback
{
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    User *u = [[User alloc] init];
    u.name = profile.name;
    
    NSString *image = [self userProfilePictureWithCGSize:CGSizeMake(200, 200)];
    [[[FBSDKGraphRequest alloc]
      initWithGraphPath:image parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"Holy shit no profile picture");
         }
         NSDictionary *data = result[@"data"];
         u.image200x200 = data[@"url"];
         callback(u);
     }];
    
}

- (NSString*)userProfilePictureWithCGSize:(CGSize)size
{
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    NSString *image = [[profile imagePathForPictureMode:FBSDKProfilePictureModeNormal size:size]
                       stringByAppendingString:@"&redirect=false"];
    return image;
}


@end
