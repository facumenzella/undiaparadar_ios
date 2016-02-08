//
//  AchievementsViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsViewController.h"
#import "AchievementsView.h"
#import "RETableViewManager+ReplaceItem.h"
#import "AchievementConfirmedPresenter.h"
#import "AchievementNotDonePresenter.h"
#import "AchievementPledgePresenter.h"

@interface AchievementsViewController ()

@property (nonatomic, strong) AchievementsView *achievementsView;
@property (nonatomic, strong) RETableViewManager *manager;

@property (nonatomic, strong) RETableViewSection *sectionAll;
@property (nonatomic, strong) RETableViewSection *sectionConfirmed;
@property (nonatomic, strong) RETableViewSection *sectionCommitment;
@property (nonatomic, strong) RETableViewSection *sectionNotDone;

@end

@implementation AchievementsViewController

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
}

- (void)registerAndBuildSections
{
    self.manager[@"AchievementPledgePresenter"] = @"AchievementCell";
    self.manager[@"AchievementConfirmedPresenter"] = @"AchievementCell";
    self.manager[@"AchievementNotDonePresenter"] = @"AchievementCell";

    [self buildAllSection];
}

- (void)buildAllSection
{
    self.sectionAll = [RETableViewSection section];
    [self.manager addSection:self.sectionAll];
    
    [self.sectionAll addItem:[[AchievementPledgePresenter alloc] initWithTitle:@""]];
    
}

@end
