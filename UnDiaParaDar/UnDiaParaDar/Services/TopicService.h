//
//  TopicService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestkitService, MappingProvider;

@interface TopicService : NSObject

-(instancetype)initWithRestkitService:(RestkitService*)restkitService
                  withMappingProvider:(MappingProvider*)mappingProvider;

+ (NSString*)offAnnotationImageById:(NSString*)topicID;
+ (NSString*)onAnnotationImageById:(NSString*)topicID;

- (NSMutableArray*)topics;
- (void)getPositiveActionsWithCallback:(void (^)(NSError* , NSArray*))callback;
- (void)getPositiveActionsFilteredByTopics:(NSArray*)topics withCallback:(void (^)(NSError *, NSArray *))callback;

@end
