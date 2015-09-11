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
#import "RETableViewManager+ReplaceItem.h"
#import "MenuProfilePresenter.h"
#import "MenuOptionPresenter.h"
#import "UserService.h"

@interface MenuViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) UserService *userService;

@property (nonatomic, strong) RETableViewManager *tableViewManager;
// Update User
@property (nonatomic, strong) RETableViewItem *profileMenuPresenter;

@end

@implementation MenuViewController

#pragma mark - MenuViewController

- (instancetype)initWithRouting:(id<Routing>)routing withUserService:(UserService*)userService
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.userService = userService;
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
    [self loadUser];
}

#pragma mark - User

- (void)loadUser
{
    [self.userService userWithCallback:^(User* u) {
        [self updateUser:u withImage:nil];
        [self.tableView reloadData];
    }];
}

- (void)updateUser:(User*)user withImage:(NSString*)image
{
    MenuProfilePresenter *presenter = [self menuProfilePresenterWithUserImage:image withUserName:user.name];
    [self.tableViewManager replaceItem:self.profileMenuPresenter withItem:presenter];
    self.profileMenuPresenter = presenter;
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
    
    self.profileMenuPresenter = [self menuProfilePresenterWithUserImage:@"avatar128x128"
                                                           withUserName:@""];
    [profileSection addItem:self.profileMenuPresenter];
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

- (MenuProfilePresenter*)menuProfilePresenterWithUserImage:(NSString*)userImage withUserName:(NSString*)userName
{
    MenuProfilePresenter *profilePresenter = [[MenuProfilePresenter alloc]
                                              initWithUserImage:userImage
                                              withUserName:userName];
    profilePresenter.selectionHandler = ^(MenuProfilePresenter* presenter) {
        
        [presenter deselectRowAnimated:NO];
        [self.routing showProfile];
    };
    return profilePresenter;
}

@end
