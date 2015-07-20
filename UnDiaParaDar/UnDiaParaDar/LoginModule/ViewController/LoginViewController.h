//
//  LoginViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;

@interface LoginViewController : UIViewController

- (instancetype)initWithRouting:(id<Routing>)routing;


@end
