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

static NSString *const kAll = @"todos";
static NSString *const kDone = @"confirmados";
static NSString *const kPledged = @"compromiso";
static NSString *const kNotDone = @"faltas";

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
    self.filtersContainer.userInteractionEnabled = YES;
    [self buildAllFilter];
    [self buildDoneFilter];
    [self buildPledged];
    [self buildNotDoneFilter];
}

- (void)buildAllFilter
{
    self.allFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.allFilter];
    [self.allFilter autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.allFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.allFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.allFilter populateWithQuantity:0 withCategory:kAll];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAll)];
    [self.allFilter addGestureRecognizer:tap];
    self.allFilter.userInteractionEnabled = YES;
}

- (void)buildDoneFilter
{
    self.doneFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.doneFilter];
    [self.doneFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.doneFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.doneFilter autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.allFilter withOffset:16];
    [self.doneFilter populateWithQuantity:0 withCategory:kDone];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDone)];
    [self.doneFilter addGestureRecognizer:tap];
    self.doneFilter.userInteractionEnabled = YES;
}

- (void)buildPledged
{
    self.pledgeFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.pledgeFilter];
    [self.pledgeFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.pledgeFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.pledgeFilter autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.doneFilter withOffset:16];
    [self.pledgeFilter populateWithQuantity:0 withCategory:kPledged];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPledged)];
    [self.pledgeFilter addGestureRecognizer:tap];
    self.pledgeFilter.userInteractionEnabled = YES;
}

- (void)buildNotDoneFilter
{
    self.notDoneFilter = [[AchievementFilterView alloc] initForAutoLayout];
    [self.filtersContainer addSubview:self.notDoneFilter];
    [self.notDoneFilter autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.notDoneFilter autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.notDoneFilter autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.pledgeFilter withOffset:16];
    [self.notDoneFilter autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.notDoneFilter populateWithQuantity:0 withCategory:kNotDone];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNotDone)];
    [self.notDoneFilter addGestureRecognizer:tap];
    self.notDoneFilter.userInteractionEnabled = YES;
}

- (void)buildTableView
{
    self.tableView = [[UITableView alloc] initForAutoLayout];
    [self addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.filtersContainer withOffset:8];
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.filtersContainer.backgroundColor = [UIColor whiteColor];
    self.allFilter.backgroundColor = [UIColor whiteColor];
    self.doneFilter.backgroundColor = [UIColor whiteColor];
    self.pledgeFilter.backgroundColor = [UIColor whiteColor];
    self.notDoneFilter.backgroundColor = [UIColor whiteColor];
}

#pragma mark - TapGestures

- (void)showAll
{
    [self.delegate didTapAll];
}

- (void)showDone
{
    [self.delegate didTapDone];
}

- (void)showNotDone
{
    [self.delegate didTapNotDone];
}

- (void)showPledged
{
    [self.delegate didTapPledged];
}

#pragma mark - Public Methods

- (void)setAll:(NSUInteger)all
{
    [self.allFilter populateWithQuantity:all withCategory:kAll];
}

- (void)setDone:(NSUInteger)done
{
    [self.doneFilter populateWithQuantity:done withCategory:kDone];
}

- (void)setPledged:(NSUInteger)pledged
{
    [self.pledgeFilter populateWithQuantity:pledged withCategory:kPledged];
}
- (void)setNotDone:(NSUInteger)notdone
{
    [self.notDoneFilter populateWithQuantity:notdone withCategory:kNotDone];
}

- (void)setActive:(AchievementFilters)filter
{
    [self.allFilter setActive:NO];
    [self.doneFilter setActive:NO];
    [self.notDoneFilter setActive:NO];
    [self.pledgeFilter setActive:NO];
    switch (filter) {
        case AchievementFiltersAll:
            [self.allFilter setActive:YES];
            break;
        case AchievementFiltersDone:
            [self.doneFilter setActive:YES];
            break;
        case AchievementFiltersNotDone:
            [self.notDoneFilter setActive:YES];
            break;
        case AchievementFiltersPledge:
            [self.pledgeFilter setActive:YES];
            break;
        default:
            break;
    }
}

@end
