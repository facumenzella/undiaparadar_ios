//
//  AchievementService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AchievementServiceState) {
    AchievementServiceStateError,
    AchievementServiceStateSuccess,
};
@interface AchievementService : NSObject

- (void)pledgesWithCallback:(void (^)(NSArray *confirmed,
                                      NSArray *done,
                                      NSArray *notdone,
                                      AchievementServiceState))callback;

@end
