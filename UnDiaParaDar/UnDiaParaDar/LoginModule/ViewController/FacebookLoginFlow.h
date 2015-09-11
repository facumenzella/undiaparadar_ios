//
//  FacebookLoginFlow.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol LoginDelegate <NSObject>

- (void)loginSucceded;
- (void)loginDidFail;

@end

@interface FacebookLoginFlow : NSObject<FBSDKLoginButtonDelegate>

+ (NSArray*)readPermissions;

- (instancetype)initWithLoginDelegate:(id<LoginDelegate>)loginDelegate;

@end
