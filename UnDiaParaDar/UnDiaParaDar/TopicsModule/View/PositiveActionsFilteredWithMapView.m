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
@property (nonatomic, strong) UISlider *slider;

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
    [self buildPositiveActionsMapView];
    [self buildSelectedTopicsView];
    [self buildSlider];
}

- (void)buildPositiveActionsMapView
{
    [self addSubview:self.positiveActionsMapView];
    [self.positiveActionsMapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}

- (void)buildSelectedTopicsView
{
    [self addSubview:self.selectedTopicsView];
    [self.selectedTopicsView autoSetDimension:ALDimensionHeight toSize:48];
    [self.selectedTopicsView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.selectedTopicsView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.positiveActionsMapView withOffset:0];
}

- (void)buildSlider
{
    // we use this container to rotate the UISlider the best way we found
    UIView *sliderContainer = [[UIView alloc] initForAutoLayout];
    sliderContainer.backgroundColor = [UIColor clearColor];
    sliderContainer.userInteractionEnabled = YES;
    [self addSubview:sliderContainer];
    
    [sliderContainer autoSetDimension:ALDimensionHeight toSize:200];
    [sliderContainer autoSetDimension:ALDimensionWidth toSize:24];
    [sliderContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.selectedTopicsView withOffset:24];
    [sliderContainer autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    
    self.slider = [[UISlider alloc] initForAutoLayout];
    self.slider.userInteractionEnabled = YES;
    self.slider.minimumValue = 1000;
    self.slider.backgroundColor = [UIColor clearColor];
    self.slider.maximumValue = self.slider.minimumValue * 100;
    self.slider.continuous = YES;
    self.slider.value = self.slider.minimumValue;
    
    [sliderContainer addSubview:self.slider];
    
    // this is inverted because we rotated 90 degrees
    [self.slider autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:sliderContainer];
    [self.slider autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:sliderContainer];
    [self.slider autoCenterInSuperview];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    self.slider.transform = transform;
}

@end
