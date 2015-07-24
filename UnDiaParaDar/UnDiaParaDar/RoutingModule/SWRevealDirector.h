//
//  SWRevealDirector.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Director.h"

typedef NS_ENUM(NSInteger, DirectorEvent) {
    DirectorEventPrimary,
    DirectorEventSecondary
};

@interface SWRevealDirector : NSObject<Director>

- (instancetype) initWithWindow:(UIWindow*)window;

- (void)setRoot:(UIViewController *)vc;

- (void)present:(UIViewController *)vc from:(UIViewController *)presenter animated:(BOOL)animated;

- (void)presentModal:(UIViewController*)vc
       withPresenter:(UIViewController*)presenter
            animated:(BOOL)animated;

- (void)dismiss:(UIViewController *)vc
       animated:(BOOL)animated
 withCompletion:(void (^)(UIViewController *))completion;

- (void) replaceStackWith:(UIViewController*)vc from:(UIViewController*)presenter;

@end
