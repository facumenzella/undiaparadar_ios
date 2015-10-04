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

- (void)viewWillAppear:(BOOL)animated
{
    if (self.tableViewManager) {
        [self loadUser];
    }
}

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
        [self updateUser:u];
        [self.tableView reloadData];
    }];
}

- (void)updateUser:(User*)user
{
    MenuProfilePresenter *presenter = [self menuProfilePresenterWithUserImage:user.image200x200 withUserName:user.name];
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
    
    self.profileMenuPresenter = [self menuProfilePresenterWithUserImage:nil
                                                           withUserName:@""];
    [profileSection addItem:self.profileMenuPresenter];
}

- (void)registerAndBuildMenuOptions
{
    RETableViewSection *itemsSection = [RETableViewSection section];
    [self.tableViewManager addSection:itemsSection];
    self.tableViewManager[@"MenuOptionPresenter"] = @"MenuOptionViewCell";
    
    // topics
    NSString *const topicsTittle = NSLocalizedString(@"TOPICS_SECTION", @"Encuentra que hacer");
    MenuOptionPresenter *topicsPresenter = [[MenuOptionPresenter alloc] initWithOptionImage:@"topics_section"
                                                                            withOptionTitle:topicsTittle];
    topicsPresenter.selectionHandler = ^(MenuOptionPresenter* presenter) {
        [presenter deselectRowAnimated:NO];
        [self.routing showProfile];
    };
    [itemsSection addItem:topicsPresenter];
    
    // map
    NSString *const mapTittle =
    NSLocalizedString(@"MAP_SECTION", @"Mapa");
    MenuOptionPresenter *mapPresenter = [[MenuOptionPresenter alloc]
                                                        initWithOptionImage:@"map_section"
                                                        withOptionTitle:mapTittle];
    mapPresenter.selectionHandler = ^(MenuOptionPresenter* presenter) {
        [presenter deselectRowAnimated:NO];
        [self.routing showPositiveActionsMapViewControllerWithPresenter:nil withSelectedTopics:nil];
    };
    [itemsSection addItem:mapPresenter];
    
    //que es UDPD
    NSString *const queESTittle =
    NSLocalizedString(@"QUEES_SECTION", @"Qué es UDPD?");
    MenuOptionPresenter *queESPresenter = [[MenuOptionPresenter alloc]
                                           initWithOptionImage:@"quees_section"
                                           withOptionTitle:queESTittle];
    queESPresenter.selectionHandler = ^(MenuOptionPresenter* presenter) {
        [presenter deselectRowAnimated:NO];
        [self.routing showQueEsUDPD];
    };
    [itemsSection addItem:queESPresenter];
    
    // t&c
    NSString *const termsAndConditionsTittle =
    NSLocalizedString(@"TERMSANDCONDITIONS_SECTION", @"Términos y condiciones");
    MenuOptionPresenter *termsAndConditionsPresenter = [[MenuOptionPresenter alloc]
                                                        initWithOptionImage:@"termsAndConditions_section"
                                                        withOptionTitle:termsAndConditionsTittle];
    termsAndConditionsPresenter.selectionHandler = ^(MenuOptionPresenter* presenter) {
        [presenter deselectRowAnimated:NO];
        [self.routing showTermsAndConditions];
    };
    [itemsSection addItem:termsAndConditionsPresenter];
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
