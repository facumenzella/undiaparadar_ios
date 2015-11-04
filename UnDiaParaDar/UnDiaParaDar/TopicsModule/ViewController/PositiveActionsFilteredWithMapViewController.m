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
#import "PositiveActionAnnotation.h"
#import "LocationManager.h"

#import "SelectedTopicsViewController.h"
#import "MapFilters.h"

#import "Routing.h"
#import "TopicService.h"

@interface PositiveActionsFilteredWithMapViewController () <PositiveActionsMapViewDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;

@property (nonatomic, strong) PositiveActionsMapView *positiveActionsView;
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
        [self addChildViewController:self.selectedTopicsViewController];
    }
    return self;
}

-(void)loadView
{
    self.positiveActionsView = [[PositiveActionsMapView alloc] init];
    [self.positiveActionsView setRadio:self.mapFilters.radio enabled:YES];
    self.positiveActionsView.pAMVDelegate = self;
    
    self.positiveFilteredView =
    [[PositiveActionsFilteredWithMapView alloc] initWithSelectedTopicsView:(SelectedTopicsCollectionView*)
     self.selectedTopicsViewController.view
                                                withPositiveActionsMapView:self.positiveActionsView];
    self.view = self.positiveFilteredView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshMapWithSelectedTopics:self.topics];
}

-(void)viewDidLoad
{
    self.title = NSLocalizedString(@"MAP_SECTION", @"Mapa");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(zoomToMyLocation)
                                                 name:kUserLocationFound
                                               object:nil];
}

- (void)refreshMapWithSelectedTopics:(NSArray*)selectedTopics
{
    [self.selectedTopicsViewController setSelectedTopics:[NSMutableArray arrayWithArray:selectedTopics]];
    [self.routing showLoadingWithPresenter:self];
    [self.topicService
     getPositiveActionsFilteredByTopics:selectedTopics
     withCallback:^(NSError *error, NSArray *positiveActions) {
         self.positiveActions = positiveActions;
         NSMutableArray *annotations = [[NSMutableArray alloc] init];
         for (PositiveAction *p in self.positiveActions) {
             id<MKAnnotation> annotation = [[PositiveActionAnnotation alloc] initWithPositiveAction:p];
             [annotations addObject:annotation];
         }
         [self.positiveActionsView addPositiveActions:annotations];
         [self.routing removeLoading];
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
            [self.positiveActionsView zoomToMyLocation];
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
    NSLog(@"range: %f", range);
    [self.positiveActionsView setRadio:range enabled:self.mapFilters.radioEnabled];
}

#pragma mark - MapFiltersHandler

- (void)handleFilters:(MapFilters*)mapFilters
{
    self.mapFilters = mapFilters;
    self.topics = self.mapFilters.selectedTopics;
    [self refreshMapWithSelectedTopics:self.topics];
    [self rangeDidChange:self.mapFilters.radio];
}

#pragma mark - PositiveActionsMapViewDelegate

- (void)didSelectShareButton
{
    // TODO
}

- (void)didSelectPledgeButton
{
    // TODO
}

- (void)didSelectDetail
{
    PositiveAction *action = self.positiveActionsView.activeAnnotation.positiveAction;
    [self.routing showPositiveaction:action withPresenter:self];
}

@end
