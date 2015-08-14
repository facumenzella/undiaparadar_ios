//
//  SplashViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SplashViewController.h"
#import "SplashView.h"

@interface SplashViewController ()

@property (nonatomic, strong) SplashView *splashView;

@end

@implementation SplashViewController

#pragma mark - SplashViewController

- (void)loadView
{
    self.splashView = [[SplashView alloc] init];
    self.view = self.splashView;
}

- (void)viewDidLoad
{
    [self.splashView animate];
}

@end
