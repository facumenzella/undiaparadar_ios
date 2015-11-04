//
//  TopicPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicCellPresenter.h"
#import "Topic.h"

@interface TopicCellPresenter ()

@property (nonatomic, strong, readwrite) Topic *topic;

@end

@implementation TopicCellPresenter

- (instancetype)initWithTopic:(Topic*)topic
{
    self = [super init];
    if (self) {
        self.topic = topic;
    }
    return self;
}

- (NSString*)name
{
    return NSLocalizedString(self.topic.name, "topic");
}
- (NSString*)image
{
    return self.topic.img;
}
- (NSString*)selectedImage
{
    return self.topic.selectedImg;
}

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[TopicCellPresenter class]]) {
        return NO;
    }
    TopicCellPresenter *t = (TopicCellPresenter*)object;
    return [t.topic isEqual:self.topic];
}

- (NSUInteger)hash
{
    return [self.topic hash];
}

@end
