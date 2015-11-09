//
//  LoadingViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoadingViewController.h"
#import "LoadingView.h"
#import "AnimatedViewProtocol.h"
#import "FakeModalAnimator.h"

@interface LoadingViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView<AnimatedViewProtocol> *modalView;
@property (nonatomic, copy) LoadingBlock loadingBlock;

@end

@implementation LoadingViewController

- (instancetype)initWithLoadingBlock:(LoadingBlock)loadingBlock
{
    self = [self init];
    if (self) {
        self.loadingBlock = loadingBlock;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)loadView
{
    self.modalView = [[LoadingView alloc] init];
    self.view = self.modalView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.modalView startAnimating];
    
    self.loadingBlock(self);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.modalView endAnimating];
}

#pragma mark - UIViewControllerTransitionDelegate
- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController*)presented
                                                                   presentingController:(UIViewController*)presenting
                                                                       sourceController:(UIViewController*)source
{
    return [[FakeModalAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[FakeModalAnimator alloc] init];
}

@end
