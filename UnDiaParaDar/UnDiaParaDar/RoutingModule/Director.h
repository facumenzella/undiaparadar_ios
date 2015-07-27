//
//  Director.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Director <NSObject>

- (void)setRoot:(UIViewController *)vc;

- (void)present:(UIViewController *)vc from:(UIViewController *)presenter animated:(BOOL)animated;

- (void)presentModal:(UIViewController*)vc
       withPresenter:(UIViewController*)presenter
            animated:(BOOL)animated;

- (void)dismiss:(UIViewController *)vc
       animated:(BOOL)animated
 withCompletion:(void (^)(UIViewController *))completion;

@optional

- (void) replaceStackWith:(UIViewController*)vc from:(UIViewController*)presenter;


@end
