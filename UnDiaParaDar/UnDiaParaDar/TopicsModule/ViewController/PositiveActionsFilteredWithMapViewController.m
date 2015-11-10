//
//  PositiveActionsFilteredWithMapViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsFilteredWithMapViewController.h"
#import "PositiveActionsMapView.h"
#import "PositiveActionsFilteredWithMapView.h"
#import "TapToRetryView.h"

#import "PositiveActionAnnotation.h"
#import "LocationManager.h"

#import "SelectedTopicsViewController.h"
#import "MapFilters.h"

#import "Routing.h"
#import "TopicService.h"

@interface PositiveActionsFilteredWithMapViewController () <PositiveActionsMapViewDelegate, TapToRetryViewDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;

@property (nonatomic, strong) TapToRetryView *tapToRetryView;
@property (nonatomic, strong) PositiveActionsFilteredWithMapView *positiveFilteredView;

@property (nonatomic, strong) SelectedTopicsViewController *selectedTopicsViewController;
@property (nonatomic, copy) SelectedTopicsChangedCallback selectedCallback;

@property (nonatomic) BOOL alreadyZoomed;
@property (nonatomic, strong) NSArray *positiveActions;

@property (nonatomic, strong) MapFilters *mapFilters;
@property (nonatomic, strong) NSArray *topics;

@end

@implementation PositiveActionsFilteredWithMapViewController

- (instancetype)initWithRouting:(id<Routing>)routing
               withTopicService:(TopicService*)topicService
                     withTopics:(NSArray*)topics
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.topicService = topicService;
        self.alreadyZoomed = NO;
        self.topics = topics;
        self.mapFilters = [[MapFilters alloc] initWithSelectedTopics:self.topics];
        
        __weak PositiveActionsFilteredWithMapViewController *welf = self;
        self.selectedCallback = ^(NSArray* selected) {
            welf.topics = selected;
            welf.mapFilters.selectedTopics = welf.topics;
            [welf refreshMapWithSelectedTopics:welf.topics];
        };
        self.selectedTopicsViewController = [[SelectedTopicsViewController alloc]
                                             initWithTopicService:self.topicService
                                             withSelectedTopicsCallback:self.selectedCallback];
    }
    return self;
}

-(void)loadView
{
    self.positiveFilteredView = [[PositiveActionsFilteredWithMapView alloc] init];
    self.view = self.positiveFilteredView;
    self.selectedTopicsViewController.collectionView = (UICollectionView*)self.positiveFilteredView.selectedTopicsView;
    self.positiveFilteredView.positiveActionsMapView.pAMVDelegate = self;
    self.tapToRetryView = [[TapToRetryView alloc] init];
    self.tapToRetryView.delegate = self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"MAP_SECTION", @"Mapa");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(zoomToMyLocation)
                                                 name:kUserLocationFound
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self handleFilters:self.mapFilters];
}

- (void)refreshMapWithSelectedTopics:(NSArray*)selectedTopics
{
    __weak PositiveActionsFilteredWithMapViewController *welf = self;
    [self.selectedTopicsViewController setSelectedTopics:[NSMutableArray arrayWithArray:selectedTopics]];
    [self.routing showLoadingWithPresenter:self withLoadingBlock:^(UIViewController *loadingVC) {
        [welf.topicService positiveActionsFilteredWith:self.mapFilters
                                          withCallback:^(NSError *error, NSArray *positiveActions) {
                                              if (error) {
                                                  welf.view = self.tapToRetryView;
                                                  [welf.routing dismissViewController:loadingVC withCompletion:nil];
                                              } else {
                                                  welf.positiveActions = positiveActions;
                                                  NSMutableArray *annotations = [[NSMutableArray alloc] init];
                                                  for (PositiveAction *p in self.positiveActions) {
                                                      id<MKAnnotation> annotation = [[PositiveActionAnnotation alloc] initWithPositiveAction:p];
                                                      [annotations addObject:annotation];
                                                  }
                                                  [welf.positiveFilteredView.positiveActionsMapView addPositiveActions:annotations];
                                                  // radio must be in meters
                                                  [self rangeDidChange:self.mapFilters.radio*1000];
                                                  [welf.routing dismissViewController:loadingVC withCompletion:nil];
                                              }
                                          }];
    }];
}

- (void)zoomToMyLocation
{
    if (self.alreadyZoomed) {
        [self removeObserver];
        return;
    }
    
    if ([LocationManager locationServicesEnabled]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.positiveFilteredView.positiveActionsMapView zoomToMyLocation];
            self.alreadyZoomed = YES;
        });
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

- (void)showFilters
{
    [self.routing showMapFiltersViewWithMapFilters:self.mapFilters withPresenter:self];
}

#pragma mark - PositiveActionsFilteredWithMapViewDelegate

- (void)rangeDidChange:(CGFloat)range
{
    [self.positiveFilteredView.positiveActionsMapView setRadio:range enabled:self.mapFilters.radioEnabled];
}

#pragma mark - MapFiltersHandler

- (void)handleFilters:(MapFilters*)mapFilters
{
    self.mapFilters = mapFilters;
    self.topics = self.mapFilters.selectedTopics;
    [self refreshMapWithSelectedTopics:self.topics];
}

#pragma mark - PositiveActionsMapViewDelegate

- (void)didSelectDetail
{
    PositiveAction *action = self.positiveFilteredView.positiveActionsMapView.activeAnnotation.positiveAction;
    [self.routing showPositiveaction:action withPresenter:self];
}

#pragma mark - TapToRetryViewDelegate

- (void)retry
{
    self.view = self.positiveFilteredView;
    [self handleFilters:self.mapFilters];
}

@end
