//
//  ProfileView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/6/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ProfileView.h"

@interface ProfileView ()

@property (nonatomic, strong) UIView *mainHeader;

@end

@implementation ProfileView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    // Inside this method you should create every subviews
}

- (void)styleSubviews
{
    // Here you should style every subviews
}

@end
