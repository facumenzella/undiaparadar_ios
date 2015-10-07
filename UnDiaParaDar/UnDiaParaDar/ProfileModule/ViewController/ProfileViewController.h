//
//  ProfileViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;
@class UserService;

@interface ProfileViewController : UIViewController

- (instancetype)initWithRouting:(id<Routing>)routing withUserService:(UserService*)userService;

@end
