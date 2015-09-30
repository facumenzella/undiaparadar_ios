//
//  MapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapViewController.h"
#import "PositiveActionsMapView.h"

#import "Routing.h"
#import "TopicService.h"

@interface PositiveActionsMapViewController () <PositiveActionsMapViewDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;
@property (nonatomic, strong) PositiveActionsMapView *positiveActionsView;

@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *positiveActions;

@end

@implementation PositiveActionsMapViewController

- (instancetype)initWithRouting:(id<Routing>)routing
               withTopicService:(TopicService*)topicService
                     withTopics:(NSArray*)topics
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.topicService = topicService;
        self.topics = topics;
    }
    return self;
}

-(void)loadView
{
    self.positiveActionsView = [[PositiveActionsMapView alloc] init];
    self.view = self.positiveActionsView;
}


- (void)viewDidLoad
{
    [self.topicService getPositiveActionsFilteredByTopics:self.topics
                                             withCallback:^(NSError *error, NSArray *positiveActions) {
        self.positiveActions = positiveActions;
                                                
                                             }];
}

#pragma mark - PositiveActionsMapViewDelegate

-(void)didSelectShareButton
{
    // TODO
}

-(void)didSelectPledgeButton
{
    // TODO
}

-(void)didSelectDetail
{
    // TODO
}

@end
