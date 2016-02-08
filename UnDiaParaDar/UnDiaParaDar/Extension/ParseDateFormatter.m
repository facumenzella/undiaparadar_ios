//
//  ParseDateFormatter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ParseDateFormatter.h"

@implementation ParseDateFormatter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDateFormat:@"dd/MM/yyyy HH:mm"];
    }
    return self;
}

@end
