//
//  FacebookShareScout.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/9/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface FacebookShareScout : NSObject

- (instancetype)initWithLink:(NSString*)shareLink
                   withTitle:(NSString*)shareTitle;

- (void)shareWithViewController:(UIViewController<FBSDKSharingDelegate>*)controller;

@end
