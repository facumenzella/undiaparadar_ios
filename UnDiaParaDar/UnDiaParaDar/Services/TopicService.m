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

static NSString * const TOPICS = @"topics";
static NSString * const NAME = @"name";
static NSString * const IMG = @"img";
static NSString * const SELECTED = @"selected";
static NSString * const CODE = @"code";

static NSMutableArray *topics;

@interface TopicService ()

@property (nonatomic, strong) RestkitService *restkitService;

@end

@implementation TopicService

-(instancetype)initWithRestkitService:(RestkitService*)restkitService
{
    self = [super init];
    if (self) {
        self.restkitService = restkitService;
    }
    return self;
}

#pragma mark - TopicService



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
