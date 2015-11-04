//
//  PositiveActionsFilteredWithMapView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectedTopicsCollectionView, PositiveActionsMapView;

@interface PositiveActionsFilteredWithMapView : UIView

-(instancetype)initWithSelectedTopicsView:(SelectedTopicsCollectionView*)selectedTopicsView
               withPositiveActionsMapView:(PositiveActionsMapView*)positiveActionsMapView;

@end
