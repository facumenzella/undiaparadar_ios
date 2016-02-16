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
#import "ParsePositiveAction.h"
#import "PositiveActionAnnotation.h"
#import "MapFilters.h"
#import "LocationManager.h"

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

- (void)positiveActionsFilteredWith:(MapFilters*)mapFilters
                       withCallback:(void (^)(TopicsServiceRequest , NSArray*))callback
{
    NSArray *filter = mapFilters.selectedTopics;
    if (!filter || filter.count == 0) {
        filter = [topics allValues];
    }
    NSArray *ids = [self topicsIdsFromTopics:filter];
    
    static NSString *const startURL = @"select?q=";
    NSString *topicsURL = [self topicsURL:ids];
    NSString *endURL = @"&wt=json&indent=true&rows=10000000";
    if (mapFilters.radioEnabled) {
        NSString* latlong = [self latLongURLWithRadius:mapFilters.radio];
        endURL = [endURL stringByAppendingString:latlong];
    }
    NSString *finalURL = [NSString stringWithFormat:@"%@%@%@", startURL, topicsURL, endURL];
    NSString *encodedURL = [[finalURL stringByRemovingPercentEncoding]
                            stringByAddingPercentEncodingWithAllowedCharacters:
                            [NSCharacterSet URLQueryAllowedCharacterSet]];
    [self getPositiveActionsWithURL:encodedURL withCallback:callback];
}

- (void)getPositiveActionsWithURL:(NSString*)url withCallback:(void (^)(TopicsServiceRequest , NSArray*))callback
{
    void (^cb)(RKMappingResult*, NSError*) = ^(RKMappingResult* result, NSError* error) {
        if ([error.domain isEqualToString:NSURLErrorDomain]) { \
            callback(TopicsServiceRequestConnectionError, nil);
        } else if (error) {
            callback(TopicsServiceRequestUnknownError, nil);
        } else {
            callback(TopicsServiceRequestSuccess, result.array);
        }
        
    };
    
    static NSString *const keyPath = @"response.docs";
    RKMapping *mapping = [self.mappingProvider positiveActionMapping];
    [self.restkitService requestToPath:url
                            withMethod:RKRequestMethodGET
                           withMapping:mapping
                            withParams:nil
                           withHeaders:nil
                           withKeyPath:keyPath
                          withCallback:cb];
}

- (void)pledgePositiveAction:(PositiveAction*)positiveAction forDate:(NSDate*)date
{
    ParsePositiveAction *action = [[ParsePositiveAction alloc] initFromPositiveAction:positiveAction
                                                                             withDate:date];
    [action saveInBackground];
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

- (NSString*)topicsURL:(NSArray*)topics
{
    if (topics.count == 1) {
        return [NSString stringWithFormat:@"topics:(%@)", topics[0]];
    }
    static NSString *const OR = @"+OR+";
    NSString *request = @"";
    for (int i = 0 ; i < [topics count] - 1; i++) {
        request = [request stringByAppendingString:topics[i]];
        request = [request stringByAppendingString:OR];
    }
    NSString *last = [topics lastObject];
    request = [request stringByAppendingString:last];
    return [[@"topics:(" stringByAppendingString:request]
            stringByAppendingString:@")"];
}

- (NSString*)latLongURLWithRadius:(NSUInteger)radius
{
    CLLocation *location = [[LocationManager sharedInstance] lastUpdate];
    static NSString *const base = @"&fq={!geofilt%20pt=";
    NSString *radiusBaseString = @"%20sfield=latlng%20d=";
    NSString *lastButNotLeast = [NSString stringWithFormat:@"%@%f,%f%@",
                                 base,
                                 location.coordinate.latitude,
                                 location.coordinate.longitude,
                                 radiusBaseString];
    return [NSString stringWithFormat:@"%@%d%@", lastButNotLeast, radius, @"}"];
}

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
