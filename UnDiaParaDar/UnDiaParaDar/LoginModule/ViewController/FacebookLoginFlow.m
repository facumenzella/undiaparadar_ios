//
//  FacebookLoginFlow.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "FacebookLoginFlow.h"

@interface FacebookLoginFlow ()

@property (nonatomic, assign) id<LoginDelegate> loginDelegate;

@end

@implementation FacebookLoginFlow

- (instancetype)initWithLoginDelegate:(id<LoginDelegate>)loginDelegate
{
    self = [super init];
    if (self) {
        self.loginDelegate = loginDelegate;
    }
    return self;
}

+ (NSArray*)readPermissions
{
    return @[@"public_profile"];
}


- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    if (error) {
        NSLog(@"Holy shit");
        [self.loginDelegate loginDidFail];
    }
    
    [self.loginDelegate loginSucceded];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"User logged out");
}

@end
