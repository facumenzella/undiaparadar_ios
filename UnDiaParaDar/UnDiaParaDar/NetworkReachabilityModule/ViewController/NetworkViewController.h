//
//  NetworkViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;

@interface NetworkViewController : UIViewController

- (instancetype)initWithRouting:(id<Routing>)routing;

@end
