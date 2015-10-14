//
//  PositiveActionsFilteredWithMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsFilteredWithMapView.h"
#import "SelectedTopicsCollectionView.h"
#import "PositiveActionsMapView.h"

#import <PureLayout/PureLayout.h>

@interface PositiveActionsFilteredWithMapView ()

@property (nonatomic, strong) SelectedTopicsCollectionView *selectedTopicsView;
@property (nonatomic, strong) PositiveActionsMapView *positiveActionsMapView;

@end

@implementation PositiveActionsFilteredWithMapView

-(instancetype)initWithSelectedTopicsView:(SelectedTopicsCollectionView*)selectedTopicsView
               withPositiveActionsMapView:(PositiveActionsMapView*)positiveActionsMapView
{
    self = [super init];
    if (self) {
        self.selectedTopicsView = selectedTopicsView;
        self.positiveActionsMapView = positiveActionsMapView;
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self addSubview:self.positiveActionsMapView];
    [self addSubview:self.selectedTopicsView];
    
    [self.positiveActionsMapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
    [self.selectedTopicsView autoSetDimension:ALDimensionHeight toSize:48];
    [self.selectedTopicsView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.selectedTopicsView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.positiveActionsMapView withOffset:0];
}

@end
