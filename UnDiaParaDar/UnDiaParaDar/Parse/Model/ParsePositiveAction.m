//
//  ParsePositiveAction.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ParsePositiveAction.h"
#import "PositiveAction.h"
#import "ParseDateFormatter.h"
#import <Parse/PFObject+Subclass.h>
#import <Parse/PFSubclassing.h>
#import <Parse/PFUser.h>

@interface ParsePositiveAction () <PFSubclassing>
@end

@implementation ParsePositiveAction

+ (NSString *)parseClassName
{
    return @"Pledge";
}

- (instancetype)initFromPositiveAction:(PositiveAction*)positiveAction withDate:(NSDate*)date
{
    self = [ParsePositiveAction object];
    if (self) {
        self.positiveActionId = [NSNumber numberWithLongLong:positiveAction.positiveActionID];
        self.positiveActionTitle = positiveAction.title;
        self.targetDate = [ParsePositiveAction formatDate:date];
        self.userId = [[PFUser currentUser] objectId];
        self.done = @(0);
    }
    return self;
}

+ (NSString*)formatDate:(NSDate*)date
{
    ParseDateFormatter *formatter = [[ParseDateFormatter alloc] init];
    return [formatter stringFromDate:date];
}

@dynamic positiveActionId;
@dynamic positiveActionTitle;
@dynamic userId;
@dynamic targetDate;
@dynamic done;

@end
