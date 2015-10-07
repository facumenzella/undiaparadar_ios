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

@interface UserService ()

@property (nonatomic, strong) User *u;

@end

@implementation UserService

- (User*)cachedUser
{
    if ([self isCachedUserAvailable]) {
        return [self.u copy];
    }
    return nil;
}

- (BOOL)isCachedUserAvailable
{
    return self.u != nil;
}

- (void)userWithCallback:(void (^)(User*))callback
{
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    self.u = [[User alloc] init];
    self.u.name = profile.name;
    
    NSString *image = [self userProfilePictureWithCGSize:CGSizeMake(250, 250)];
    [[[FBSDKGraphRequest alloc]
      initWithGraphPath:image parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (error) {
             NSLog(@"Holy shit no profile picture");
         } else {
             NSDictionary *data = result[@"data"];
             self.u.image200x200 = data[@"url"];
         }
         callback([self.u copy]);
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
