//
//  User.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/11/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "User.h"

@implementation User

- (id)copyWithZone:(NSZone *)zone
{
    User *copy = [[[self class] alloc] init];
    if (copy) {
        copy.name = [self.name copy];
        copy.image200x200 = [self.image200x200 copy];
    }
    return copy;
}

@end
