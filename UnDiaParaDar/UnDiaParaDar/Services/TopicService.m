//
//  TopicService.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicService.h"
#import "Topic.h"

static NSString * const TOPICS = @"topics";
static NSString * const NAME = @"name";
static NSString * const IMG = @"img";

static NSMutableArray *topics;

@implementation TopicService

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
            [topics addObject:t];
        }
    });
    return topics;
}

@end
