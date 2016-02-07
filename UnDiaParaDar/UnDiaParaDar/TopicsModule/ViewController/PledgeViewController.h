//
//  PlegeViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/5/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;

@interface PledgeViewController : UIViewController

- (instancetype)initWithRouting:(id<Routing>)routing;

@end
