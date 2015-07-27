//
//  Tailor.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWRevealDirector.h"

@protocol Tailor <NSObject>

- (void)suitViewControllerUpForPrimaryEvent:(UIViewController*)viewController;

@end
