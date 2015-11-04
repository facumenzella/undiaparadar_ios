//
//  Topic.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "Topic.h"

@implementation Topic

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[Topic class]]) {
        return NO;
    }
    Topic *t = (Topic*)object;
    return [t.code isEqualToString:self.code];
}

- (NSUInteger)hash
{
    return [self.code hash];
}

@end
