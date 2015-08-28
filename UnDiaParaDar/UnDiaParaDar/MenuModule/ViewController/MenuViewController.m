//
//  MenuViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuViewController.h"
#import "Routing.h"
#import "RETableViewManager.h"
#import "MenuProfilePresenter.h"
#import "MenuOptionPresenter.h"

@interface MenuViewController ()

@property (nonatomic, strong) id<Routing> routing;

@property (nonatomic, strong) RETableViewManager *tableViewManager;

@end

@implementation MenuViewController

#pragma mark - MenuViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableViewManager];
    [self registerAndBuildProfileSection];
    [self registerAndBuildMenuOptions];
}

#pragma mark - RETableViewManager

- (void)initTableViewManager
{
    // we do not like this, but we do not have a better method yet
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBounces:NO];
    
    self.tableViewManager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    // we do not like this, but we do not have a better method yet
    self.tableViewManager.style.defaultCellSelectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)registerAndBuildProfileSection
{
    RETableViewSection *profileSection = [RETableViewSection section];
    [self.tableViewManager addSection:profileSection];
    self.tableViewManager[@"MenuProfilePresenter"] = @"MenuProfileViewCell";
    
    MenuProfilePresenter *profilePresenter = [[MenuProfilePresenter alloc]
                                              initWithUserImage:@"avatar128x128"
                                              withUserName:@"Jon Snow"];
    profilePresenter.selectionHandler = ^(MenuProfilePresenter* presenter) {
        
        [presenter deselectRowAnimated:NO];
        [self.routing showProfile];
    };
    [profileSection addItem:profilePresenter];
}

- (void)registerAndBuildMenuOptions
{
    RETableViewSection *itemsSection = [RETableViewSection section];
    [self.tableViewManager addSection:itemsSection];
    self.tableViewManager[@"MenuOptionPresenter"] = @"MenuOptionViewCell";
    
    MenuOptionPresenter *topicsPresenter = [[MenuOptionPresenter alloc] initWithOptionImage:@"topic_section"
                                                                            withOptionTitle:@"Topics"];
    topicsPresenter.selectionHandler = ^(MenuOptionPresenter* presenter) {
        [presenter deselectRowAnimated:NO];
        [self.routing showProfile];
    };
    [itemsSection addItem:topicsPresenter];
}

@end
