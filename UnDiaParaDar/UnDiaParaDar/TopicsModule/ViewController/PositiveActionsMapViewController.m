//
//  MapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapViewController.h"
#import "PositiveActionsMapView.h"
#import "PositiveActionAnnotation.h"
#import "LocationManager.h"

#import "Routing.h"
#import "TopicService.h"

@interface PositiveActionsMapViewController () <PositiveActionsMapViewDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;
@property (nonatomic, strong) PositiveActionsMapView *positiveActionsView;

@property (nonatomic) BOOL alreadyZoomed;
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
        self.alreadyZoomed = NO;
    }
    return self;
}

-(void)loadView
{
    self.positiveActionsView = [[PositiveActionsMapView alloc] init];
    self.positiveActionsView.pAMVDelegate = self;
    self.view = self.positiveActionsView;
}

-(void)viewDidLoad
{
    self.title = NSLocalizedString(@"MAP_SECTION", @"Mapa");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(zoomToMyLocation)
                                                 name:kUserLocationFound
                                               object:nil];
}

- (void)zoomToMyLocation
{
    if (self.alreadyZoomed) {
        [self removeObserver];
        return;
    }
    
    if ([LocationManager locationServicesEnabled]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.positiveActionsView zoomToMyLocation];
            self.alreadyZoomed = YES;
        });
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.positiveActions) {
        [self.routing showLoadingWithPresenter:self];
        [self.topicService
         getPositiveActionsFilteredByTopics:self.topics
         withCallback:^(NSError *error, NSArray *positiveActions) {
             self.positiveActions = positiveActions;
             NSMutableArray *annotations = [[NSMutableArray alloc] init];
             for (PositiveAction *p in self.positiveActions) {
                 id<MKAnnotation> annotation = [[PositiveActionAnnotation alloc] initWithPositiveAction:p];
                 [annotations addObject:annotation];
             }
             [self.routing removeLoading];
             [self.positiveActionsView addPositiveActions:annotations];
         }];
    }
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc
{
    [self removeObserver];
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
    PositiveAction *action = self.positiveActionsView.activeAnnotation.positiveAction;
    [self.routing showPositiveaction:action withPresenter:self];
}

@end
