//
//  AchievementService.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementService.h"
#import "Achievement.h"
#import "ParseDateFormatter.h"
#import <Parse/Parse.h>

@implementation AchievementService

- (void)confirmAchievement:(Achievement*)achievement
{
    PFObject *pledge = [PFObject objectWithoutDataWithClassName:@"Pledge" objectId:achievement.objectId];
    [pledge setObject:@(1) forKey:@"done"];
    [pledge save];
}


- (void)pledgesWithCallback:(void (^)(NSArray *confirmed,
                                      NSArray *done,
                                      NSArray *notdone,
                                      AchievementServiceState))callback
{
    PFQuery *query = [PFQuery queryWithClassName:@"Pledge"];
    [query whereKey:@"userId" equalTo:[[PFUser currentUser] objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *c = [[NSMutableArray alloc] init];
            NSMutableArray *nd = [[NSMutableArray alloc] init];
            NSMutableArray *d = [[NSMutableArray alloc] init];

            NSLog(@"Successfully retrieved %d scores.", objects.count);
            for (PFObject *object in objects) {
                Achievement *achieve = [[Achievement alloc] init];
                achieve.positiveActionId = [object objectForKey:@"positiveActionId"];
                achieve.title = [object objectForKey:@"positiveActionTitle"];
                achieve.done = [object objectForKey:@"done"];
                achieve.code = [object objectForKey:@"code"];
                achieve.objectId = [object objectId];
                [self classifyAchievement:achieve withTargetDate:[object objectForKey:@"targetDate"]];
                switch (achieve.state) {
                    case AchievementStateDone:
                        [d addObject:achieve];
                        break;
                    case AchievementStateNotDone:
                        [object setObject:@(2) forKey:@"done"];
                        [object saveInBackground];
                        [nd addObject:achieve];
                        break;
                    case AchievementStatePledge:
                        [c addObject:achieve];
                        break;
                    default:
                        break;
                }
            }
            callback(c, d, nd, AchievementServiceStateSuccess);
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            callback(nil, nil, nil, AchievementServiceStateError);
        }
    }];
}

- (void)classifyAchievement:(Achievement*)achievement withTargetDate:(NSString*)dateString
{
    if ([achievement.done isEqualToNumber:@(2)]) {
        achievement.state = AchievementStateNotDone;
        return;
    } else if ([achievement.done isEqualToNumber:@(1)]) {
        achievement.state = AchievementStateDone;
        return;
    }
    
    ParseDateFormatter *formatter = [[ParseDateFormatter alloc] init];
    NSDate *targetDate = [formatter dateFromString:dateString];
    NSDate *currentDate = [NSDate date];
    
    int days = [currentDate timeIntervalSinceDate:targetDate] / (60*60*24);
    if (days >=7) {
        achievement.state = AchievementStateNotDone;
        achievement.done = @(2);
    } else {
        achievement.state = AchievementStatePledge;
        achievement.done = @(0);
    }
}

@end
