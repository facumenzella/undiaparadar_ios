//
//  PositiveActionsFilteredWithMapView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectedTopicsCollectionView, PositiveActionsMapView;
@protocol PositiveActionsFilteredWithMapViewDelegate;

@interface PositiveActionsFilteredWithMapView : UIView

@property (nonatomic, assign) id<PositiveActionsFilteredWithMapViewDelegate> delegate;

-(instancetype)initWithSelectedTopicsView:(SelectedTopicsCollectionView*)selectedTopicsView
               withPositiveActionsMapView:(PositiveActionsMapView*)positiveActionsMapView;

@end

@protocol PositiveActionsFilteredWithMapViewDelegate <NSObject>

- (void)rangeDidChange:(CGFloat)range;

@end
