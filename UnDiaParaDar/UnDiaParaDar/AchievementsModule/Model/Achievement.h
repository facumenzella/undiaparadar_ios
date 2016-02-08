//
//  Achievement.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AchievementState) {
    AchievementStateNotDone,
    AchievementStatePledge,
    AchievementStateDone,
};

@interface Achievement : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL confirmEnabled;
@property (nonatomic) AchievementState state;
@property (nonatomic, strong) NSNumber *positiveActionId;
@property (nonatomic, strong) NSNumber *done;

@end
