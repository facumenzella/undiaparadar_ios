//
//  AchievementConfirmedPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementConfirmedPresenter.h"

@interface AchievementConfirmedPresenter ()

@property (nonatomic, strong, readwrite) NSString *state;

@end

@implementation AchievementConfirmedPresenter

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        self.state = @"confirmedPledge";
        self.enabled = NO;
    }
    return self;
}

@end
