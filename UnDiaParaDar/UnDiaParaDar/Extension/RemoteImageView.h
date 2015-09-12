//
//  RemoteImageView.h
//  Register
//
//  Created by Juan Pablo Civile on 02/08/13.
//  Copyright (c) 2013 Silvina Roldan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoteImageView : UIImageView

@property (nonatomic, strong) UIImage *placeHolderImage;
@property (nonatomic) BOOL activityIndicatorEnabled;

- (void)setRemoteURL:(NSString*)remoteURL;
- (void)setRemoteURL:(NSString *)remoteURL withCallbackStatus:(void (^)(BOOL status))callbackStatus;

@end
