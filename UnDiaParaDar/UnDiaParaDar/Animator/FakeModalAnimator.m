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
    fromViewController.view.userInteractionEnabled = YES;
    [modalViewController.view removeFromSuperview];
    [context completeTransition:YES];
}

- (void)presentModal:(UIViewController*)modalViewController
  fromViewController:(UIViewController *)fromViewController
          andContext:(id <UIViewControllerContextTransitioning>)context
{
    CGRect frame = [context finalFrameForViewController:modalViewController];
    // The doc says that we might get a frame, and if we do, we have to respect it
    if (CGRectIsEmpty(frame)) {
        frame = fromViewController.view.frame;
    }
    fromViewController.view.userInteractionEnabled = NO;
    [context.containerView addSubview:modalViewController.view];
    modalViewController.view.frame = frame;
    
    [context completeTransition:YES];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)context
{
    // Grab the from and to view controllers from the context
    UIViewController *fromViewController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (toViewController.isBeingPresented) {
        [self presentModal:toViewController
        fromViewController:fromViewController
                andContext:context];
    } else {
        [self dismissModal:fromViewController
        fromViewController:toViewController
                andContext:context];
    }
    return;
}

@end
