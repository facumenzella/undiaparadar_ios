//
//  AchievementService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Achievement;

typedef NS_ENUM(NSUInteger, AchievementServiceState) {
    AchievementServiceStateError,
    AchievementServiceStateNoAnswer,
    AchievementServiceStateSuccess
};

@interface AchievementService : NSObject

- (void)pledgesWithCallback:(void (^)(NSArray *confirmed,
                                      NSArray *done,
                                      NSArray *notdone,
                                      AchievementServiceState))callback;

- (void)confirmAchievement:(Achievement*)achievement;

@end
