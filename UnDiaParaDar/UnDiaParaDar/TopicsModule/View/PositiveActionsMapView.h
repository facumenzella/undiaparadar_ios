//
//  PositiveActionsMapView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol PositiveActionsMapViewDelegate;
@class PositiveActionAnnotation;

@interface PositiveActionsMapView : UIView

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic) CLLocationDistance radius;

@property (nonatomic, assign) id <PositiveActionsMapViewDelegate> pAMVDelegate;
@property (nonatomic, strong) PositiveActionAnnotation *activeAnnotation;

- (void)addPositiveActions:(NSArray*)positiveActions;
- (void)showActivePositiveActionWithTitle:(NSString*)title withSubtitle:(NSString*)subttitle;
- (void)zoomToMyLocation;

@end

@protocol PositiveActionsMapViewDelegate <NSObject>

- (void)didSelectShareButton;

- (void)didSelectPledgeButton;

- (void)didSelectDetail;

@end