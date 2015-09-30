//
//  PositiveActionAnnotation.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/30/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class PositiveAction;

@interface PositiveActionAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithPositiveAction:(PositiveAction*)positiveAction;


@end
