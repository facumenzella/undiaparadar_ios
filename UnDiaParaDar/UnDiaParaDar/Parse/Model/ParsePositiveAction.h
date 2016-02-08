//
//  ParsePositiveAction.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"

@class PositiveAction;

@interface ParsePositiveAction : PFObject

+ (NSString *)parseClassName;
- (instancetype)initFromPositiveAction:(PositiveAction*)positiveAction withDate:(NSDate*)date;

@property (nonatomic, strong) NSNumber *positiveActionId;
@property (nonatomic, strong) NSString *positiveActionTitle;
@property (nonatomic, strong) NSString *targetDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSNumber *done;

@end
