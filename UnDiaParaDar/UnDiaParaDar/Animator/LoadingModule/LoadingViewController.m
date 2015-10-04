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

@interface LoadingViewController ()

@property (nonatomic, strong) UIView<AnimatedViewProtocol> *modalView;
@property (nonatomic, strong) FakeModalAnimator *modalAnimator;

@end

@implementation LoadingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalAnimator = [[FakeModalAnimator alloc] init];
        self.transitioningDelegate = self.modalAnimator;
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.modalView endAnimating];
}


@end
