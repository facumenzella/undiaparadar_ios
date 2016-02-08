//
//  AchievementsView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsView.h"
#import "AchievementFilterView.h"

#import <PureLayout/PureLayout.h>

@interface AchievementsView ()

@property (nonatomic, strong) UIView *filtersContainer;
@property (nonatomic, strong) AchievementFilterView *allFilter;
@property (nonatomic, strong) AchievementFilterView *doneFilter;
@property (nonatomic, strong) AchievementFilterView *pledgeFilter;
@property (nonatomic, strong) AchievementFilterView *notDoneFilter;

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation AchievementsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildTopFilters];
    [self buildTableView];
}

- (void)buildTopFilters
{
    static NSUInteger kTopInset = 16;
    self.filtersContainer = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.filtersContainer];
    [self.filtersContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kTopInset];
    [self.filtersContainer autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.filtersContainer autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                            withInset:0
                                             relation:NSLayoutRelationGreaterThanOrEqual];
    [self.filtersContainer autoPinEdgeToSuperviewEdge:ALEdgeRight
                                            withInset:0
                                             relation:NSLayoutRelationGreaterThanOrEqual];
    
    self.allFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.allFilter];
    [self.allFilter autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.allFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.allFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.allFilter populateWithQuantity:@"100" withCategory:@"todos"];
    
    self.doneFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.doneFilter];
    [self.doneFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.doneFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.doneFilter autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.allFilter withOffset:16];
    [self.doneFilter populateWithQuantity:@"50" withCategory:@"confirmados"];

    self.pledgeFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.pledgeFilter];
    [self.pledgeFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.pledgeFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.pledgeFilter autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.doneFilter withOffset:16];
    [self.pledgeFilter populateWithQuantity:@"30" withCategory:@"compromiso"];

    self.notDoneFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.notDoneFilter];
    [self.notDoneFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.notDoneFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.notDoneFilter autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.pledgeFilter withOffset:16];
    [self.notDoneFilter autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.notDoneFilter populateWithQuantity:@"20" withCategory:@"faltas"];
}


- (void)buildTableView
{
    self.tableView = [[UITableView alloc] initForAutoLayout];
    [self addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.filtersContainer withOffset:0];
}

- (void)styleSubviews
{
    // Here you should style every subviews
}

@end
