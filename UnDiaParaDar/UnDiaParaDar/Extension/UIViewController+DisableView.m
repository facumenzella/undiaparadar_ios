//
//  UIViewController+DisableView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "UIViewController+DisableView.h"

@implementation UIViewController (DisableView)

- (void)disableViewInteraction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // maybe show some fancy spinner or whatever
        self.view.userInteractionEnabled = NO;
    });
}
- (void)enableViewInteraction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // remove your spinner
        self.view.userInteractionEnabled = NO;
    });
}

@end
