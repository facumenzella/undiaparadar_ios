//
//  LocationManager.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString * const kUserLocationFound;

@interface LocationManager : NSObject

@property (nonatomic, strong, readonly) CLLocation *lastUpdate;

+ (instancetype)sharedInstance;
+ (BOOL)locationServicesEnabled;

@end
