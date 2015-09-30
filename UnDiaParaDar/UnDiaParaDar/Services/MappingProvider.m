//
//  MappingProvider.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MappingProvider.h"
#import "PositiveAction.h"

@implementation MappingProvider

- (RKMapping*)positiveActionMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[PositiveAction class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"positiveActionID",
                                                  @"latlng_0_coordinate": @"latitude",
                                                  @"latlng_1_coordinate": @"longitude",
                                                  @"video_url": @"videoURL",
                                                  @"external_url": @"externalURL",
                                                  @"title": @"title",
                                                  @"subtitle": @"subtitle",
                                                  @"desc": @"positiveActionDescription",
                                                  @"ong_name": @"ongName",
                                                  @"ong_id": @"ongID",
                                                  @"topics": @"topicID",
                                                  @"country": @"country",
                                                  @"city": @"city"
                                                  }];
    return mapping;
    
}

@end
