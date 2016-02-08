//
//  ParseLoginHound.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ParseLoginHound.h"
#import "FacebookLoginFlow.h"
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

@implementation ParseLoginHound

- (void)login
{
    [PFFacebookUtils logInInBackgroundWithReadPermissions:[FacebookLoginFlow readPermissions]
                                                    block:^(PFUser *user, NSError *error) {
                                                        if (!user) {
                                                            NSLog(@"Uh oh. The user cancelled the Facebook login.");
                                                            [self.delegate loginDidFail];
                                                        } else if (user.isNew) {
                                                            NSLog(@"User signed up and logged in through Facebook!");
                                                            [self.delegate loginSucceded];
                                                        } else {
                                                            NSLog(@"User logged in through Facebook!");
                                                            [self.delegate loginSucceded];
                                                        }
                                                    }];
}

@end
