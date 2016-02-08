//
//  MenuViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;
@class UserService;

@interface MenuViewController : UITableViewController

- (instancetype)initWithRouting:(id<Routing>)routing withUserService:(UserService*)userService;

@end
