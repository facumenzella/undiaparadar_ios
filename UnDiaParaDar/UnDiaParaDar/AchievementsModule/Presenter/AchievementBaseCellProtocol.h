//
//  AchievementBaseCellProtocol.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kNewPledge = @"newPledge";
static NSString *const kconfirmedPledge = @"confirmedPledge";
static NSString *const kNotDonePledge = @"notDonePledge";

@protocol AchievementBaseCellProtocol <NSObject>

- (BOOL)confirmEnabled;
- (NSString*)title;
- (NSString*)state;

@end
