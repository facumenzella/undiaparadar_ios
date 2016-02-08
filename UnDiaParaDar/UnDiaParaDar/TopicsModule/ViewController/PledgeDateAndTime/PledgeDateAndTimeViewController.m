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
#import "PositiveAction.h"
#import "TopicService.h"

static NSArray *reminders;

@interface PledgeDateAndTimeViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) PledgeDateAndTimeView *pledgeView;
@property (nonatomic, strong) RETableViewManager *manager;

@property (nonatomic, strong) REDateTimeItem *dateItem;
@property (nonatomic, strong) REDateTimeItem *hourItem;
@property (nonatomic, strong) REPickerItem *reminderItem;

@property (nonatomic, strong) PositiveAction *positiveAction;
@property (nonatomic, strong) TopicService *topicService;
@end

@implementation PledgeDateAndTimeViewController

- (instancetype)initWithRouting:(id<Routing>)routing
             withPositiveAction:(PositiveAction*)positiveAction
               withTopicService:(TopicService*)topicService
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.positiveAction = positiveAction;
        self.topicService = topicService;
        [self buildReminders];
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

- (void)buildReminders
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reminders = @[NSLocalizedString(@"REMINDER_HALF_HOUR", @"Media hora antes"),
                      NSLocalizedString(@"REMINDER_ONE_HOUR", @"Una hora antes"),
                      NSLocalizedString(@"REMINDER_TWELVE_HOUR", @"12 Horas antes"),
                      NSLocalizedString(@"REMINDER_ONE_DAY", @"Un dia antes"),
                      NSLocalizedString(@"REMINDER_NO", @"No gracias")];
    });
}

- (void)registerAndBuildSections
{
    [self buildPositiveActionSection];
    
    [self buildDateSection];
    [self buildTimeSection];
    [self buildReminderSection];
}

- (void)buildPositiveActionSection
{
    RETableViewSection *positiveSection = [RETableViewSection section];
    RETableViewItem *item = [RETableViewItem itemWithTitle:NSLocalizedString(@"POSITIVE_ACTION", @"Accion positiva")
                                             accessoryType:UITableViewCellAccessoryDetailButton
                                          selectionHandler:^(RETableViewItem *item) {
                                              [item deselectRowAnimated:YES];
                                              [self.routing showPositiveaction:self.positiveAction
                                                                 withPresenter:self];
                                          }];
    item.detailLabelText = self.positiveAction.title;
    [positiveSection addItem:item];
    
    [self.manager addSection:positiveSection];
}

- (void)buildDateSection
{
    RETableViewSection *dateSection = [RETableViewSection section];
    [self.manager addSection:dateSection];
    
    self.dateItem = [REDateTimeItem itemWithTitle:@"Date"
                                            value:[NSDate date]
                                      placeholder:nil
                                           format:@"MM/dd/yyyy"
                                   datePickerMode:UIDatePickerModeDate];
    [dateSection addItem:self.dateItem];
}

- (void)buildTimeSection
{
    RETableViewSection *timeSection = [RETableViewSection section];
    [self.manager addSection:timeSection];
    
    self.hourItem = [REDateTimeItem itemWithTitle:@"Time"
                                            value:[NSDate date]
                                      placeholder:nil
                                           format:@"hh:mm"
                                   datePickerMode:UIDatePickerModeTime];
    [timeSection addItem:self.hourItem];
}

- (void)buildReminderSection
{
    RETableViewSection *reminderSection = [RETableViewSection section];
    [self.manager addSection:reminderSection];
    self.reminderItem = [REPickerItem itemWithTitle:@"Recordatorio"
                                              value:@[reminders[reminders.count - 1]]
                                        placeholder:nil
                                            options:@[reminders]];
    [reminderSection addItem:self.reminderItem];
}

#pragma mark - LeftCancelButtonProtocol

- (void)cancel
{
    [self.manager.tableView reloadData];
    [self.routing dismissViewController:self withCompletion:^(UIViewController*vc) {
        [self.routing showPledgeViewControllerForPositiveAction:nil withPresenter:vc];
    }];
}

#pragma mark - RightConfirmButtonProtocol

- (void)confirm
{
    NSDate *pledgeDate = [self pledgeDate];
    NSDate *finalDate = [self calculateReminderDateFromPledgeDate:pledgeDate];
    NSLog(@"date: %@", finalDate);
    if (![self.reminderItem.value[0] isEqualToString:[reminders lastObject]]) {
        [[[LocalNotificationHound alloc] initWithDate:finalDate withMessage:@"Remember to do this shit"] setup];
    }
    [self.topicService pledgePositiveAction:self.positiveAction forDate:pledgeDate];
}

- (NSDate*)pledgeDate
{
    NSDate *date = self.dateItem.value;
    unsigned dateUnits = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDate *hour = self.hourItem.value;
    unsigned hourUnits = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:dateUnits fromDate:date];
    
    NSDate *finalDateWithoutReminder = [[NSCalendar currentCalendar] dateFromComponents:comps];
    comps = [[NSCalendar currentCalendar] components:hourUnits fromDate:hour];
    finalDateWithoutReminder = [[NSCalendar currentCalendar] dateByAddingComponents:comps
                                                                             toDate:finalDateWithoutReminder
                                                                            options:0];
    
    return finalDateWithoutReminder;
}

- (NSDate*)calculateReminderDateFromPledgeDate:(NSDate*)date
{
    return [date dateByAddingTimeInterval:-[self reminder]];
}

- (NSTimeInterval)reminder
{
    static NSTimeInterval halfHour = 30 * 60;
    static NSTimeInterval hour = 60 * 60;
    static NSTimeInterval twelveHours = 60 * 60 * 12;
    static NSTimeInterval oneDay = 60 * 60 * 24;
    
    if ([self.reminderItem.value[0] isEqualToString:reminders[0]]) {
        return halfHour;
    } else if ([self.reminderItem.value[0] isEqualToString:reminders[1]]) {
        return hour;
    } else if ([self.reminderItem.value[0] isEqualToString:reminders[2]]) {
        return twelveHours;
    } else {
        return oneDay;
    }
}

@end
