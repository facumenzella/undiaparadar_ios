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

@interface LoadingViewController ()

@property (nonatomic, strong) UIView<AnimatedViewProtocol> *modalView;

@end

@implementation LoadingViewController

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
