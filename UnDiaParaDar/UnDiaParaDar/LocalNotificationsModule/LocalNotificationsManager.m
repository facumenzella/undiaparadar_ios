//
//  LocalNotificationsController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "LocalNotificationsManager.h"
#import <UIKit/UIUserNotificationSettings.h>
#import <UIKit/UIApplication.h>

@implementation LocalNotificationsManager

+ (instancetype)sharedInstance
{
    static LocalNotificationsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setup];
    });
    return sharedInstance;
}

- (void)setup
{
    [self checkPermissions];
}

- (void)checkPermissions
{
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (!settings || !(settings.types & UIUserNotificationTypeAlert & UIUserNotificationTypeBadge)) {
        [self askPermissions];
    }
}

- (void)askPermissions
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge
                                           categories:nil]];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

@end
