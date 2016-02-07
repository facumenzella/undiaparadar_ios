//
//  PledgeDateAndTimeView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeDateAndTimeView.h"

@interface PledgeDateAndTimeView ()

@end

@implementation PledgeDateAndTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    // Inside this method you should create every subviews
    // For example
    // [self buildProfileImageView];
    // [self buildMainHeader];
}

- (void)styleSubviews
{
    // Here you should style every subviews
}

@end
