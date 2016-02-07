//
//  PlegeViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/5/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeViewController.h"
#import "PledgePopupView.h"

#import "Routing.h"

@interface PledgeViewController () <PledgeViewDelegate>

@property (nonatomic, strong) PledgePopupView *pledgeView;

@property (nonatomic, strong) id<Routing> routing;

@end

@implementation PledgeViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pledgeView modalStyle];
}

- (void)loadView
{
    self.pledgeView = [[PledgePopupView alloc] init];
    self.pledgeView.delegate = self;
    self.view = self.pledgeView;
}

#pragma mark - PledgeViewDelegate

- (void)pledge
{
    
}

- (void)keepLooking
{
    [self.routing dismissViewController:self withCompletion:nil];
}

@end
