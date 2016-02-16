//
//  NetworkViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "NetworkViewController.h"
#import "NoConnectionPopupView.h"
#import "Routing.h"

@interface NetworkViewController ()<NoConnectionPopupViewDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) NoConnectionPopupView *popup;

@end

@implementation NetworkViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)loadView
{
    self.popup = [[NoConnectionPopupView alloc] init];
    self.popup.delegate = self;
    self.view = self.popup;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.popup modalStyle];
}

#pragma mark - NoConnectionPopupViewDelegate

- (void)understood
{
    [self.routing dismissViewController:self withCompletion:nil];
}

@end
