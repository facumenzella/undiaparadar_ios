//
//  UDPDWebView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/10/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "UDPDWebView.h"

@interface UDPDWebView () <UIWebViewDelegate>

@end

@implementation UDPDWebView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
