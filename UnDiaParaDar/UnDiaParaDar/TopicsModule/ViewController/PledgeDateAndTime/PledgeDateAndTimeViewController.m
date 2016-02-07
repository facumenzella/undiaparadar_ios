//
//  PledgeDateAndTimeViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeDateAndTimeViewController.h"
#import "Routing.h"
#import "PledgeDateAndTimeView.h"
#import "RETableViewManager+ReplaceItem.h"
#import "LocalNotificationHound.h"

@interface PledgeDateAndTimeViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) PledgeDateAndTimeView *pledgeView;
@property (nonatomic, strong) RETableViewManager *manager;

@property (nonatomic, strong) REDateTimeItem *dateItem;
@property (nonatomic, strong) REDateTimeItem *hourItem;

@end

@implementation PledgeDateAndTimeViewController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

- (void)loadView
{
    self.pledgeView = [[PledgeDateAndTimeView alloc] init];
    self.view = self.pledgeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"I_PLEDGE", @"Me comprometo");
    self.manager = [[RETableViewManager alloc] initWithTableView:self.pledgeView.tableView];
    [self registerAndBuildSections];
}

- (void)registerAndBuildSections
{
    RETableViewSection *dateSection = [RETableViewSection section];
    [self.manager addSection:dateSection];
    
    self.dateItem = [REDateTimeItem itemWithTitle:@"Date"
                                            value:[NSDate date]
                                      placeholder:nil
                                           format:@"MM/dd/yyyy"
                                   datePickerMode:UIDatePickerModeDate];
    [dateSection addItem:self.dateItem];
    
    RETableViewSection *timeSection = [RETableViewSection section];
    [self.manager addSection:timeSection];
    
    self.hourItem = [REDateTimeItem itemWithTitle:@"Time"
                                            value:[NSDate date]
                                      placeholder:nil
                                           format:@"hh:mm"
                                   datePickerMode:UIDatePickerModeTime];
    [timeSection addItem:self.hourItem];
}

#pragma mark - LeftCancelButtonProtocol

- (void)cancel
{
    [self.routing dismissViewController:self withCompletion:^(UIViewController*vc) {
        [self.routing showPledgeViewControllerWithPresenter:vc];
    }];
}

#pragma mark - RightConfirmButtonProtocol

- (void)confirm
{
    NSDate *hour = self.hourItem.value;
    NSDate *date = self.dateItem.value;
    
    unsigned dateUnits = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    unsigned hourUnits = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;

    NSDateComponents *comps = [[NSCalendar currentCalendar] components:dateUnits fromDate:date];
    
    NSDate *finalDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    comps = [[NSCalendar currentCalendar] components:hourUnits fromDate:hour];
    finalDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:finalDate options:0];
    
    [[[LocalNotificationHound alloc] initWithDate:finalDate withMessage:@"Remember to do this shit"] setup];
}

@end
