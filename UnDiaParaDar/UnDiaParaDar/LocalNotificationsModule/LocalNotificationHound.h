//
//  LocalNotificationHound.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationHound : NSObject

- (instancetype)initWithDate:(NSDate*)date withMessage:(NSString*)msg;
- (void)setup;

@end
