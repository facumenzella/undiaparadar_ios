//
//  PlegeViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/5/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeViewController.h"
#import "PledgePopupView.h"
#import "PositiveAction.h"

#import "Routing.h"

@interface PledgeViewController () <PledgeViewDelegate>

@property (nonatomic, strong) PledgePopupView *pledgeView;
@property (nonatomic, strong) PositiveAction *positiveAction;

@property (nonatomic, strong) id<Routing> routing;

@end

@implementation PledgeViewController

- (instancetype)initWithRouting:(id<Routing>)routing withPositiveAction:(PositiveAction*)positiveAction
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.positiveAction = positiveAction;
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
    [self.routing dismissViewController:self withCompletion:^(UIViewController* vc) {
        [self.routing showPledgeDateAndTimeOptionsForPositiveAction:self.positiveAction withPresenter:self];
    }];
}

- (void)keepLooking
{
    [self.routing dismissViewController:self withCompletion:nil];
}

@end
