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

@interface AchievementsViewController ()

@property (nonatomic, strong) AchievementsView *achievementsView;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) AchievementService *service;

@property (nonatomic, strong) RETableViewSection *sectionAll;
@property (nonatomic, strong) RETableViewSection *sectionDone;
@property (nonatomic, strong) RETableViewSection *sectionPledge;
@property (nonatomic, strong) RETableViewSection *sectionNotDone;

@property (nonatomic, strong) NSArray *done;
@property (nonatomic, strong) NSArray *pledge;
@property (nonatomic, strong) NSArray *notdone;


@end

@implementation AchievementsViewController

- (instancetype)initWithAchievementService:(AchievementService*)service
{
    self = [super init];
    if (self) {
        self.service = service;
    }
    return self;
}

- (void)loadView
{
    self.achievementsView = [[AchievementsView alloc] init];
    self.view = self.achievementsView;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"ACHIEVEMENTS_SECTION", @"Logros");
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.achievementsView.tableView];
    
    [self registerAndBuildSections];
    [self.service pledgesWithCallback:^(NSArray *pledge,
                                        NSArray *done,
                                        NSArray *notdone,
                                        AchievementServiceState state) {
        switch (state) {
            case AchievementServiceStateError:
                [self showError];
                break;
            case  AchievementServiceStateSuccess:
                self.done = done;
                self.notdone = notdone;
                self.pledge = pledge;
                [self populateSections];
                break;
            default:
                break;
        }
    }];
}

- (void)showError
{
    self.pledge = nil;
    self.done = nil;
    self.notdone = nil;
}

- (void)populateSections
{
    for (Achievement *a in self.pledge) {
        AchievementPledgePresenter *p = [[AchievementPledgePresenter alloc] initWithTitle:a.title];
        [self.sectionPledge addItem:p];
    }
    for (Achievement *a in self.done) {
        AchievementConfirmedPresenter *p = [[AchievementConfirmedPresenter alloc] initWithTitle:a.title];
        [self.sectionDone addItem:p];
    }
    for (Achievement *a in self.notdone) {
        AchievementNotDonePresenter *p = [[AchievementNotDonePresenter alloc] initWithTitle:a.title];
        [self.sectionNotDone addItem:p];
    }
    [self.manager addSection:self.sectionPledge];
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

@end
