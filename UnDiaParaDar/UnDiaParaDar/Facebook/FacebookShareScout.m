//
//  FacebookShareScout.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/9/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "FacebookShareScout.h"

@interface FacebookShareScout ()

@property (nonatomic, strong) NSString *shareLink;
@property (nonatomic, strong) NSString *shareTitle;

@end

@implementation FacebookShareScout

- (instancetype)initWithLink:(NSString*)shareLink
                   withTitle:(NSString*)shareTitle
{
    self = [super init];
    if (self) {
        self.shareLink = shareLink;
        self.shareTitle = shareTitle;
    }
    return self;
}

- (void)shareWithViewController:(UIViewController<FBSDKSharingDelegate>*)controller
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:self.shareLink];
    content.contentTitle = self.shareTitle;
    
    [FBSDKShareDialog showFromViewController:controller
                                 withContent:content
                                    delegate:controller];
}

@end
