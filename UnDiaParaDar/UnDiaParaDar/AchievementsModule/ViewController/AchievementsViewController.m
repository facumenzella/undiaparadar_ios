//
//  AchievementsViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsViewController.h"
#import "AchievementsView.h"
#import "Achievement.h"
#import "RETableViewManager+ReplaceItem.h"
#import "AchievementConfirmedPresenter.h"
#import "AchievementNotDonePresenter.h"
#import "AchievementPledgePresenter.h"
#import "AchievementService.h"
#import "Routing.h"

#import "TapToRetryView.h"
#import "UnknownErrorTapToRetryPresenter.h"
#import "NoConnectionTapToRetryPresenter.h"

@interface AchievementsViewController () <AchievementViewDelegate, AchievementCellDelegate, TapToRetryViewDelegate>

@property (nonatomic, strong) AchievementsView *achievementsView;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) AchievementService *service;
@property (nonatomic, strong) id<Routing> routing;

@property (nonatomic, strong) TapToRetryView *tapToRetry;
@property (nonatomic, strong) UnknownErrorTapToRetryPresenter *unknownTapToRetry;
@property (nonatomic, strong) NoConnectionTapToRetryPresenter *noConnectionTapToRetry;

@property (nonatomic, strong) RETableViewSection *sectionAll;
@property (nonatomic, strong) RETableViewSection *sectionDone;
@property (nonatomic, strong) RETableViewSection *sectionPledge;
@property (nonatomic, strong) RETableViewSection *sectionNotDone;
@property (nonatomic, strong) RETableViewSection *active;

@property (nonatomic, strong) NSArray *done;
@property (nonatomic, strong) NSArray *pledge;
@property (nonatomic, strong) NSArray *notdone;

@end

@implementation AchievementsViewController

- (instancetype)initWithAchievementService:(AchievementService*)service withRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.service = service;
        self.routing = routing;
        
        self.tapToRetry = [[TapToRetryView alloc] init];
        self.tapToRetry.delegate = self;
        self.noConnectionTapToRetry = [[NoConnectionTapToRetryPresenter alloc] init];
        self.unknownTapToRetry = [[UnknownErrorTapToRetryPresenter alloc] init];
    }
    return self;
}

- (void)loadView
{
    self.achievementsView = [[AchievementsView alloc] init];
    self.achievementsView.delegate = self;
    self.view = self.achievementsView;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"ACHIEVEMENTS_SECTION", @"Logros");
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.achievementsView.tableView];
    
    [self registerAndBuildSections];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.done && self.pledge && self.notdone) {
        [self reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reload];
}

- (void)reload
{
    [self.routing showLoadingWithPresenter:self withLoadingBlock:^(UIViewController*loading) {
        [self.routing dismissViewController:loading withCompletion:nil];
        self.done = @[];
        self.notdone = @[];
        self.pledge = @[];
        [self populateSections];
    }];
}

- (void)showError:(id<TapToRetryViewPresenter>)presenter
{
    self.pledge = nil;
    self.done = nil;
    self.notdone = nil;
    
    self.view =  self.tapToRetry;
    [self.tapToRetry setPresenter:presenter];
}

- (void)populateSections
{
    self.view = self.achievementsView;
    for (Achievement *a in self.pledge) {
        AchievementPledgePresenter *p = [[AchievementPledgePresenter alloc] initWithTitle:a.title];
        p.achieve = a;
        p.delegate = self;
        AchievementPledgePresenter *pa = [[AchievementPledgePresenter alloc] initWithTitle:a.title];
        pa.achieve = a;
        pa.delegate = self;
        [self.sectionPledge addItem:p];
        [self.sectionAll addItem:pa];
    }
    [self.achievementsView setPledged:self.pledge.count];
    for (Achievement *a in self.done) {
        AchievementConfirmedPresenter *p = [[AchievementConfirmedPresenter alloc] initWithTitle:a.title];
        p.achieve = a;
        AchievementConfirmedPresenter *pa = [[AchievementConfirmedPresenter alloc] initWithTitle:a.title];
        pa.achieve = a;
        [self.sectionDone addItem:p];
        [self.sectionAll addItem:pa];
    }
    [self.achievementsView setDone:self.done.count];
    for (Achievement *a in self.notdone) {
        AchievementNotDonePresenter *p = [[AchievementNotDonePresenter alloc] initWithTitle:a.title];
        p.achieve = a;
        AchievementNotDonePresenter *pa = [[AchievementNotDonePresenter alloc] initWithTitle:a.title];
        pa.achieve = a;
        [self.sectionNotDone addItem:p];
        [self.sectionAll addItem:pa];
    }
    [self.achievementsView setNotDone:self.notdone.count];
    [self.achievementsView setAll: (self.notdone.count + self.done.count + self.pledge.count)];
    
    self.active = self.sectionPledge;
    [self.achievementsView setActive:AchievementFiltersPledge];
    [self reloadData];
}

- (void)reloadData
{
    [self.manager addSection:self.active];
    [self.manager.tableView reloadData];
}

- (void)registerAndBuildSections
{
    self.manager[@"AchievementPledgePresenter"] = @"AchievementCell";
    self.manager[@"AchievementConfirmedPresenter"] = @"AchievementCell";
    self.manager[@"AchievementNotDonePresenter"] = @"AchievementCell";
    
    [self buildSections];
}

- (void)buildSections
{
    self.sectionAll = [RETableViewSection section];
    self.sectionDone = [RETableViewSection section];
    self.sectionPledge = [RETableViewSection section];
    self.sectionNotDone = [RETableViewSection section];
}

#pragma mark - AchievementViewDelegate

- (void)didTapAll
{
    if (![self.active isEqual:self.sectionAll]) {
        [self.manager removeSectionsInArray:@[self.sectionPledge,
                                              self.sectionNotDone,
                                              self.sectionDone,
                                              self.sectionAll]];
        
        self.active = self.sectionAll;
        [self.achievementsView setActive:AchievementFiltersAll];
        [self reloadData];
    }
}

- (void)didTapDone
{
    if (![self.active isEqual:self.sectionDone]) {
        [self.manager removeSectionsInArray:@[self.sectionPledge,
                                              self.sectionNotDone,
                                              self.sectionDone,
                                              self.sectionAll]];
        self.active = self.sectionDone;
        [self.achievementsView setActive:AchievementFiltersDone];
        
        [self reloadData];
    }
}

- (void)didTapNotDone
{
    if (![self.active isEqual:self.sectionNotDone]) {
        [self.manager removeSectionsInArray:@[self.sectionPledge,
                                              self.sectionNotDone,
                                              self.sectionDone,
                                              self.sectionAll]];
        self.active = self.sectionNotDone;
        [self.achievementsView setActive:AchievementFiltersNotDone];
        
        [self reloadData];
    }
}

- (void)didTapPledged
{
    if (![self.active isEqual:self.sectionPledge]) {
        [self.manager removeSectionsInArray:@[self.sectionPledge,
                                              self.sectionNotDone,
                                              self.sectionDone,
                                              self.sectionAll]];
        self.active = self.sectionPledge;
        [self.achievementsView setActive:AchievementFiltersPledge];
        
        [self reloadData];
    }
}

- (void)pledgeWithItem:(id<AchievementBaseCellProtocol>)item
{
    [self.routing showPledgeConfirmationWithAchievement:[item achieve] withPresenter:self];
}

#pragma mark - TapToRetryViewDelegate

- (void)retry
{
    self.view = self.achievementsView;
    [self reload];
}

@end
