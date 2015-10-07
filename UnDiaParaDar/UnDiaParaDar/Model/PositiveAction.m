//
//  PositiveAction.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveAction.h"

@implementation PositiveAction

- (NSString*)paTitle
{
    return self.title;
}

- (NSString*)paSubtitle
{
    return self.subtitle;
}

- (NSString*)paDescription
{
    return self.positiveActionDescription;
}

- (NSString*)paCity
{
    return self.city;
}

- (NSString*)paCountry
{
    return self.country;
}

- (NSString*)paExternalURL
{
    return self.externalURL;
}

@end
