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
#import "SelectedTopicsCollectionView.h"

#import <PureLayout/PureLayout.h>

@interface PositiveActionsFilteredWithMapView ()

@property (nonatomic, strong, readwrite) SelectedTopicsCollectionView *selectedTopicsView;
@property (nonatomic, strong, readwrite) PositiveActionsMapView *positiveActionsMapView;

@end

@implementation PositiveActionsFilteredWithMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildPositiveActionsMapView];
    [self buildSelectedTopicsView];
}

- (void)buildPositiveActionsMapView
{
    self.positiveActionsMapView = [[PositiveActionsMapView alloc] init];
    [self addSubview:self.positiveActionsMapView];
    [self.positiveActionsMapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}

- (void)buildSelectedTopicsView
{
    self.selectedTopicsView = [[SelectedTopicsCollectionView alloc] init];
    [self addSubview:self.selectedTopicsView];
    [self.selectedTopicsView autoSetDimension:ALDimensionHeight toSize:48];
    [self.selectedTopicsView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.selectedTopicsView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.positiveActionsMapView withOffset:0];
}

@end
