//
//  SplashView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SplashViewProtocol <NSObject>

- (void)animate;

@end

@interface SplashView : UIView<SplashViewProtocol>

@end
