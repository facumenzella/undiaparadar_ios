//
//  TopicService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestkitService, MappingProvider, Topic, MapFilters, PositiveAction;

typedef NS_ENUM(NSUInteger, TopicsServiceRequest) {
    TopicsServiceRequestSuccess,
    TopicsServiceRequestConnectionError,
    TopicsServiceRequestUnknownError
};

@interface TopicService : NSObject

-(instancetype)initWithRestkitService:(RestkitService*)restkitService
                  withMappingProvider:(MappingProvider*)mappingProvider;

+ (NSString*)offAnnotationImageById:(NSString*)topicID;
+ (NSString*)onAnnotationImageById:(NSString*)topicID;

- (NSMutableArray*)topics;
- (Topic*)topicById:(NSString*)topicId;

- (void)positiveActionsFilteredWith:(MapFilters*)mapFilters
                       withCallback:(void (^)(TopicsServiceRequest , NSArray*))callback;
- (void)pledgePositiveAction:(PositiveAction*)positiveAction forDate:(NSDate*)date;

@end
