//
//  PositiveActionViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionViewController.h"
#import "PositiveActionView.h"
#import "PositiveAction.h"

#import "Routing.h"

@interface PositiveActionViewController ()

@property (nonatomic, strong) id<Routing> routing;

@property (nonatomic, strong) PositiveActionView *positiveActionView;
@property (nonatomic, strong) PositiveAction *positiveAction;

@end

@implementation PositiveActionViewController

- (instancetype)initWithPositiveAction:(PositiveAction*)positiveAction withRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.positiveAction = positiveAction;
    }
    return self;
}

- (void)loadView
{
    self.positiveActionView = [[PositiveActionView alloc] init];
    self.view = self.positiveActionView;
}

@end
