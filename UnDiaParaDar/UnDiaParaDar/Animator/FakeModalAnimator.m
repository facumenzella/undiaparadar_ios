//
//  FakeModalAnimator.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 Monits. All rights reserved.
//

#import "FakeModalAnimator.h"

@implementation FakeModalAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0;
}

- (void)dismissModal:(UIViewController*)modalViewController
  fromViewController:(UIViewController*)fromViewController
          andContext:(id <UIViewControllerContextTransitioning>)context
{
    [fromViewController dismissViewControllerAnimated:NO completion:^(void){
        [context completeTransition:YES];
    }];
}

- (void)presentModal:(UIViewController*)modalViewController
  fromViewController:(UIViewController*)fromViewController
          andContext:(id <UIViewControllerContextTransitioning>)context
{
    [fromViewController presentViewController:modalViewController animated:NO completion:^(void){
        [context completeTransition:YES];
    }];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)context
{
    return;
}

@end
