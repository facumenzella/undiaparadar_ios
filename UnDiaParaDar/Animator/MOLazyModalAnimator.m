//
//  MOLazyModalAnimator.m
//  ClaroViajes
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 Monits. All rights reserved.
//

#import "MOLazyModalAnimator.h"
#import "RoutingService.h"

@interface MOLazyModalAnimator ()

@property (nonatomic, strong) RoutingService *routingService;

@end

@implementation MOLazyModalAnimator

- (instancetype)initWithRoutingService:(RoutingService*)routingService
{
    self = [super init];
    if (self) {
        self.routingService = routingService;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UNUSED(transitionContext);
    return 0;
}

- (void)dismissModal:(UIViewController*)modalViewController
  fromViewController:(UIViewController*)fromViewController
          andContext:(id <UIViewControllerContextTransitioning>)context
{
    UNUSED(fromViewController);
    [self.routingService dismiss:modalViewController animated:NO withCompletion:^(UIViewController* presenter){
        UNUSED(presenter);
        [context completeTransition:YES];
    }];

}

- (void)presentModal:(UIViewController*)modalViewController
  fromViewController:(UIViewController*)fromViewController
          andContext:(id <UIViewControllerContextTransitioning>)context
{
    UNUSED(context);
    [self.routingService present:modalViewController withPresenter:fromViewController animated:NO];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)context
{
    UNUSED(context);
    return;
}

@end
