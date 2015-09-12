//
//  RemoteImageView.m
//  Register
//
//  Created by Juan Pablo Civile on 02/08/13.
//  Copyright (c) 2013 Silvina Roldan. All rights reserved.
//

#import "RemoteImageView.h"
#import "UIImageView+AFNetworking.h"
#import <libkern/OSAtomic.h>

#import <UIView+AutoLayout.h>

@interface RemoteImageView ()

@property (nonatomic,strong) UIActivityIndicatorView *spinner;
@property (nonatomic,strong) UIView *overlay;

@property (nonatomic, strong) NSString* remoteURL;

@end

@implementation RemoteImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.overlay = [[UIView alloc] initForAutoLayout];
        [self.overlay setBackgroundColor:[UIColor clearColor]];
        self.overlay.layer.cornerRadius = 0;
        self.spinner = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.overlay];
        [self.overlay autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [self.overlay addSubview:self.spinner];
        [self.spinner autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.spinner autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    }
    return self;
}

- (void)setRemoteURL:(NSString *)remoteURL
{
    if (remoteURL != nil) {
        [self setRemoteURL:remoteURL withCallbackStatus:nil];
    }
    _remoteURL = remoteURL;
}

- (void)setRemoteURL:(NSString *)remoteURL withCallbackStatus:(void (^)(BOOL status))callbackStatus
{
    if (remoteURL != nil) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:remoteURL]];
        __block RemoteImageView *remoteImageView = self;
        if (self.activityIndicatorEnabled) {
            [self addSpinner];
        }
        [self setImageWithURLRequest:request
                    placeholderImage:self.placeHolderImage
                             success:^(NSURLRequest *aRequest, NSHTTPURLResponse *response, UIImage *obj) {
                                 if (obj) {
                                     remoteImageView.image = obj;
                                     if (callbackStatus) {
                                         callbackStatus(YES);
                                     }
                                 } else {
                                     if (callbackStatus) {
                                         callbackStatus(NO);
                                     }
                                 }
                             }
                             failure:^(NSURLRequest *aRequest, NSHTTPURLResponse *response, NSError *error) {
                                 if (callbackStatus) {
                                     callbackStatus(NO);
                                 }
                             }];
    } else {
        if (callbackStatus) {
            callbackStatus(YES);
        }
    }
    _remoteURL = remoteURL;
}

#pragma mark - Placeholder

- (void)setPlaceHolderImage:(UIImage *)placeHolder
{
    [self setActivityIndicatorEnabled:NO];
    [self setImage:placeHolder];
}

#pragma mark - UIActivityIndicatorView

- (void)setActivityIndicatorEnabled:(BOOL)enabled
{
    if (enabled) {
        [self addSpinner];
    } else {
        [self removeSpinner];
    }
    _activityIndicatorEnabled = enabled;
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    [self removeSpinner];
}

- (void)addSpinner
{
    [self.spinner startAnimating];
    self.overlay.hidden = NO;
}

- (void)removeSpinner
{
    [self.spinner stopAnimating];
    self.overlay.hidden = YES;
    
}

@end
