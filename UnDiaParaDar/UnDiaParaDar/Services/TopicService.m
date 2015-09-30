//
//  TopicService.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicService.h"
#import "Topic.h"

#import "RestkitService.h"
#import "MappingProvider.h"

static NSString * const TOPICS = @"topics";
static NSString * const NAME = @"name";
static NSString * const IMG = @"img";
static NSString * const SELECTED = @"selected";
static NSString * const CODE = @"code";

static NSMutableArray *topics;

static NSString *const ALL = @"select?q=topics:(1+OR+2+OR+5+OR+6+OR+7+OR+8+OR+9+OR+10+OR+13+OR+14+OR+15+OR+16+OR+18+OR+20+OR+21+OR+22+OR+24)&wt=json&indent=true&rows=10000000";

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
    }
    return self;
}

#pragma mark - TopicService

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

- (NSMutableArray*)topics
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        topics = [[NSMutableArray alloc]init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:TOPICS ofType:@"plist"];
        NSArray *topicsDictionary = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *d in topicsDictionary) {
            Topic *t = [[Topic alloc] init];
            t.name = d[NAME];
            t.img = d[IMG];
            t.selectedImg = d[SELECTED];
            t.code = d[CODE];
            [topics addObject:t];
        }
    });
    return topics;
}

@end
