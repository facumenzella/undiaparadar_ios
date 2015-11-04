//
//  MapFiltersView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/1/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MapFiltersView.h"
#import "BeautyCenter.h"
#import "SelectedTopicsCollectionView.h"
#import "FiltersViewCollectionLayout.h"

#import <PureLayout/PureLayout.h>

static NSString *BACKGROUND_KEY = @"Splash";

static NSUInteger const kLeftInset = 24;
static NSUInteger const kRightInset = kLeftInset;
static NSUInteger const kLineSeparator = kLeftInset;
static NSUInteger const kSectionSeparator = 2 * kLeftInset;

@interface MapFiltersView()

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UILabel *radioSectionTitle;
@property (nonatomic, strong) UISwitch *radioSwitch;
@property (nonatomic, strong) UISlider *radioSlider;
@property (nonatomic, strong) UILabel *radio;

@property (nonatomic, strong) UILabel *topicsSectionTitle;
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@end

@implementation MapFiltersView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildBackgroundView];
    [self buildRadioSection];
    [self buildTopicsSection];
}

- (void)buildBackgroundView
{
    self.backgroundView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:self.backgroundView];
    self.backgroundView.image = [UIImage imageNamed:BACKGROUND_KEY];
    [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 32, 64, 32)];
    self.backgroundView.userInteractionEnabled = YES;
}

- (void)buildRadioSection
{
    [self buildRadioTitle];
    [self buildRadioSwitch];
    [self buildRadioSlider];
    [self buildRadio];
}

- (void)buildRadioTitle
{
    self.radioSectionTitle = [[UILabel alloc] initForAutoLayout];
    [self.backgroundView addSubview:self.radioSectionTitle];
    [self.radioSectionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLeftInset];
    [self.radioSectionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:48];
    self.radioSectionTitle.text = NSLocalizedString(@"RADIO", @"Radio");
}

- (void)buildRadioSwitch
{
    self.radioSwitch = [[UISwitch alloc] initForAutoLayout];
    [self.backgroundView addSubview:self.radioSwitch];
    [self.radioSwitch autoPinEdge:ALEdgeLeft
                           toEdge:ALEdgeRight
                           ofView:self.radioSectionTitle
                       withOffset:0
                         relation:NSLayoutRelationGreaterThanOrEqual];
    [self.radioSwitch autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kRightInset];
    [self.radioSwitch autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.radioSectionTitle];
}

- (void)buildRadioSlider
{
    self.radioSlider = [[UISlider alloc] initForAutoLayout];
    [self.backgroundView addSubview:self.radioSlider];
    [self.radioSlider autoPinEdge:ALEdgeTop
                           toEdge:ALEdgeBottom
                           ofView:self.radioSectionTitle
                       withOffset:kLineSeparator];
    [self.radioSlider autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLeftInset];
    [self.radioSlider autoMatchDimension:ALDimensionWidth
                             toDimension:ALDimensionWidth
                                  ofView:self.backgroundView
                          withMultiplier:.5];
}

- (void)buildRadio
{
    self.radio = [[UILabel alloc] initForAutoLayout];
    [self.backgroundView addSubview: self.radio];
    [self.radio autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kRightInset];
    [self.radio autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.radioSlider];
    [self.radio autoPinEdge:ALEdgeLeft
                     toEdge:ALEdgeRight
                     ofView:self.radioSlider
                 withOffset:0
                   relation:NSLayoutRelationGreaterThanOrEqual];
    [self.radio autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.radioSwitch];
    self.radio.text = @"10 km";
}

- (void)buildTopicsSection
{
    [self buildTopicsTitle];
    [self buildCollectionView];
}

- (void)buildTopicsTitle
{
    self.topicsSectionTitle = [[UILabel alloc] initForAutoLayout];
    [self.backgroundView addSubview:self.topicsSectionTitle];
    [self.topicsSectionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLeftInset];
    [self.topicsSectionTitle autoPinEdge:ALEdgeTop
                                  toEdge:ALEdgeBottom
                                  ofView:self.radioSlider
                              withOffset:kSectionSeparator];
    [self.topicsSectionTitle autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    self.topicsSectionTitle.text = NSLocalizedString(@"TOPICS", @"Topics");
}

- (void)buildCollectionView
{
    FiltersViewCollectionLayout *layout = [[FiltersViewCollectionLayout alloc] init];
    self.collectionView = [[SelectedTopicsCollectionView alloc] initWithUICollectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addSubview:self.collectionView];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLineSeparator];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kLineSeparator];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLineSeparator];
    [self.collectionView autoPinEdge:ALEdgeTop
                              toEdge:ALEdgeBottom
                              ofView:self.topicsSectionTitle
                          withOffset:kLineSeparator];
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.cornerRadius = 30;
    self.backgroundView.clipsToBounds = YES;
    
    UIFont *titleFont = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                       withSize:BeautyCenterTypographySizeD];
    UIFont *radioFont = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                       withSize:BeautyCenterTypographySizeC];
    self.radioSectionTitle.textAlignment = NSTextAlignmentLeft;
    self.radioSectionTitle.font = titleFont;
    self.radio.font = radioFont;
    self.topicsSectionTitle.textAlignment = NSTextAlignmentLeft;
    self.topicsSectionTitle.font = titleFont;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
}

@end
