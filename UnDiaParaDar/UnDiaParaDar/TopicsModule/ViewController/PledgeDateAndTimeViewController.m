//
//  PledgeDateAndTimeViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeDateAndTimeViewController.h"
#import "Routing.h"

@interface PledgeDateAndTimeViewController ()

@property (nonatomic, strong) id<Routing> routing;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"I_PLEDGE", @"Me comprometo");
}

@end
