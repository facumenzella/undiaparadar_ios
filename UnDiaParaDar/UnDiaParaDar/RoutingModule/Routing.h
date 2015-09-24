//
//  Routing.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing <NSObject>

- (void)showLoginPage;
- (void)showMainPage;
- (void)showProfile;
- (void)showSplash;
- (void)showPositiveActionsMapViewControllerWithPresenter:(UIViewController*)vc
                                           withSelectedTopics:(NSArray*)topics;
- (void)showTermsAndConditions;
- (void)showQueEsUDPD;

@end
