//
//  LoginView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)login;

@end

@interface LoginView : UIView

- (instancetype) initWithFacebookLoginDelegate:(id<LoginViewDelegate>)loginDelegate;

- (void)animate;

@end
