//
//  TopicService.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicService.h"
#import "Topic.h"
#import "PositiveAction.h"
#import "PositiveActionAnnotation.h"

#import "RestkitService.h"
#import "MappingProvider.h"

static NSString * const TOPICS = @"topics";
static NSString * const NAME = @"name";
static NSString * const IMG = @"img";
static NSString * const SELECTED = @"selected";
static NSString * const CODE = @"code";
static NSString * const MAP_ON = @"mapOn";
static NSString * const MAP_OFF = @"mapOff";

static NSMutableDictionary *topics;

static NSString *ALL;

@interface TopicService ()

@property (nonatomic, strong) RestkitService *restkitService;
@property (nonatomic, strong) MappingProvider *mappingProvider;

@end

@implementation TopicService

-(instancetype)initWithRestkitService:(RestkitService*)restkitService
                  withMappingProvider:(MappingProvider*)mappingProvider
{
    self = [super init];
    if (self) {
        self.restkitService = restkitService;
        self.mappingProvider = mappingProvider;
        [self topics];
    }
    return self;
}

#pragma mark - TopicService

- (void)getPositiveActionsFilteredByTopics:(NSArray*)filterTopics withCallback:(void (^)(NSError *, NSArray *))callback
{
    NSArray *filter = filterTopics;
    if (!filter) {
        filter = [topics allValues];
    }
    
    NSArray *ids = [self topicsIdsFromTopics:filter];
    void (^cb)(NSError *, NSArray *) = ^(NSError *error, NSArray *positives) {
        NSPredicate *topicsActions = [NSPredicate predicateWithBlock:^BOOL(PositiveAction *p, NSDictionary *bindings) {
            return [ids containsObject:p.topicID];
        }];
        
        NSArray *filteredArray = [positives filteredArrayUsingPredicate:topicsActions];
        callback(error, filteredArray);
    };
    [self getPositiveActionsWithCallback:cb];
}

- (void)getPositiveActionsWithCallback:(void (^)(NSError* , NSArray*))callback
{
    void (^cb)(RKMappingResult*, NSError*) = ^(RKMappingResult* result, NSError* error) {
        callback(error, result.array);
    };
    
    static NSString *const keyPath = @"response.docs";
    RKMapping *mapping = [self.mappingProvider positiveActionMapping];
    [self.restkitService requestToPath:ALL
                            withMethod:RKRequestMethodGET
                           withMapping:mapping
                            withParams:nil
                           withHeaders:nil
                           withKeyPath:keyPath
                          withCallback:cb];
}

- (Topic*)topicById:(NSString*)topicId
{
    return [topics objectForKey:topicId];
}


- (NSArray*)topics
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        topics = [[NSMutableDictionary alloc]init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:TOPICS ofType:@"plist"];
        NSArray *topicsDictionary = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *d in topicsDictionary) {
            Topic *t = [[Topic alloc] init];
            t.name = d[NAME];
            t.img = d[IMG];
            t.selectedImg = d[SELECTED];
            t.code = d[CODE];
            t.img40x40Off = d[MAP_OFF];
            t.img40x40On = d[MAP_ON];
            [topics setObject:t forKey:t.code];
        }
    });
    [self buildAllURL];
    return [topics allValues];;
}

#pragma mark - Annotations


+ (NSString*)offAnnotationImageById:(NSString*)topicID
{
    return ((Topic*)[topics objectForKey:topicID]).img40x40Off;
}

+ (NSString*)onAnnotationImageById:(NSString*)topicID
{
    return ((Topic*)[topics objectForKey:topicID]).img40x40On;
}

#pragma mark - IDS

- (NSArray*)topicsIdsFromTopics:(NSArray*)topics
{
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    for (Topic *t in topics) {
        [filtered addObject:t.code];
    }
    return filtered;
}

#pragma mark - URLS

- (void)buildAllURL
{
    static NSString *const OR = @"+OR+";
    __block NSString *all = @"";
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *topicsA = [topics allValues];
        for (int i = 0 ; i < [topicsA count] - 1; i++) {
            all = [all stringByAppendingString:((Topic*)(topicsA[i])).code];
            all = [all stringByAppendingString:OR];
        }
        Topic *last = [topicsA lastObject];
        all = [all stringByAppendingString:last.code];
        ALL = [[@"select?q=topics:(" stringByAppendingString:all] stringByAppendingString:@")&wt=json&indent=true&rows=10000000"];
    });
}

@end
