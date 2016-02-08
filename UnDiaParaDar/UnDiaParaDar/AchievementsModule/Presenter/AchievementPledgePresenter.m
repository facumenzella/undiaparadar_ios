//
//  AchievementPledgePresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementPledgePresenter.h"

@interface AchievementPledgePresenter ()

@property (nonatomic, strong, readwrite) NSString *state;
@property (nonatomic, readwrite) BOOL confirmEnabled;

@end

@implementation AchievementPledgePresenter

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        self.state = kNewPledge;
        self.confirmEnabled = YES;
    }
    return self;
}

@end
