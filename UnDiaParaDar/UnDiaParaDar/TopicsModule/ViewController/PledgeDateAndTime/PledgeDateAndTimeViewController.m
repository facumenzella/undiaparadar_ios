//
//  PledgeDateAndTimeViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeDateAndTimeViewController.h"
#import "Routing.h"
#import "PledgeDateAndTimeView.h"

@interface PledgeDateAndTimeViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) PledgeDateAndTimeView *pledgeView;

@end

@implementation PledgeDateAndTimeViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

- (void)loadView
{
    self.pledgeView = [[PledgeDateAndTimeView alloc] init];
    self.view = self.pledgeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"I_PLEDGE", @"Me comprometo");
}

#pragma mark - LeftCancelButtonProtocol

- (void)cancel
{
    [self.routing dismissViewController:self withCompletion:^(UIViewController*vc) {
        [self.routing showPledgeViewControllerWithPresenter:vc];
    }];
}

@end
