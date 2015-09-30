//
//  PositiveActionsMapView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PositiveActionsMapViewDelegate;

@interface PositiveActionsMapView : UIView

@property (nonatomic, assign) id <PositiveActionsMapViewDelegate> pAMVDelegate;

- (void)addPositiveActions:(NSArray*)positiveActions;

@end

@protocol PositiveActionsMapViewDelegate <NSObject>

- (void)didSelectShareButton;

- (void)didSelectPledgeButton;

- (void)didSelectDetail;

@end