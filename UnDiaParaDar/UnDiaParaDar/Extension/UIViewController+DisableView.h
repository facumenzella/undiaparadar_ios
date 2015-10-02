//
//  UIViewController+DisableView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DisableView)

- (void)disableViewInteraction;
- (void)enableViewInteraction;

@end
