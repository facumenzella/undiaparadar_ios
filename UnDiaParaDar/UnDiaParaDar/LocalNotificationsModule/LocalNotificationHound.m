//
//  LocalNotificationHound.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "LocalNotificationHound.h"

#import <UIKit/UILocalNotification.h>
#import <UIKit/UIApplication.h>
#import "LocalNotificationsManager.h"

@interface LocalNotificationHound ()

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *msg;

@end

@implementation LocalNotificationHound

- (instancetype)initWithDate:(NSDate*)date withMessage:(NSString*)msg
{
    self = [super init];
    if (self) {
        self.date = date;
        self.msg = msg;
    }
    return self;
}

- (void)setup
{
    [[LocalNotificationsManager sharedInstance] checkPermissions];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = self.date;
    localNotification.alertBody = self.msg;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
