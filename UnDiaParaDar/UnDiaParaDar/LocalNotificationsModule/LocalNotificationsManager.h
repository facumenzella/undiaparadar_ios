//
//  LocalNotificationsController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationsManager : NSObject

+ (instancetype)sharedInstance;
- (void)checkPermissions;

@end
