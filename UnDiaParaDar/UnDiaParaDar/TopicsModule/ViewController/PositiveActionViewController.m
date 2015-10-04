//
//  PositiveActionViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionViewController.h"
#import "PositiveActionView.h"
#import "PositiveAction.h"
#import "Topic.h"

#import "Routing.h"
#import "TopicService.h"

@interface PositiveActionViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;

@property (nonatomic, strong) PositiveActionView *positiveActionView;
@property (nonatomic, strong) PositiveAction *positiveAction;

@end

@implementation PositiveActionViewController

- (instancetype)initWithPositiveAction:(PositiveAction*)positiveAction
                           withRouting:(id<Routing>)routing
                      withTopicService:(TopicService*)topicService
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.topicService = topicService;
        self.positiveAction = positiveAction;
    }
    return self;
}

- (void)loadView
{
    self.positiveActionView = [[PositiveActionView alloc] init];
    self.view = self.positiveActionView;
}

- (void)viewDidLoad
{
    Topic *topic = [self.topicService topicById:self.positiveAction.topicID];
    [self.positiveActionView populateWithPositiveAction:self.positiveAction withTopicImage:topic.selectedImg];
}

@end
