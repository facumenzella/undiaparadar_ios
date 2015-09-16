//
//  MapViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;

@interface PositiveActionsWithMapViewController : UIViewController

- (instancetype)initWithRouting:(id<Routing>)routing;

@end
