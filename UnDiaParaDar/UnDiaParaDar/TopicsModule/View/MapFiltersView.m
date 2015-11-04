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
static NSUInteger kMaxRadio = 5000;

static NSUInteger const kLeftInset = 24;
static NSUInteger const kRightInset = kLeftInset;
static NSUInteger const kLineSeparator = kLeftInset * .75;
static NSUInteger const kSectionSeparator = kLeftInset;

@interface MapFiltersView()<UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UILabel *radioSectionTitle;
@property (nonatomic, strong) UISwitch *radioSwitch;
@property (nonatomic, strong) UISlider *radioSlider;
@property (nonatomic, strong) UILabel *radioLabel;

@property (nonatomic, strong) UILabel *topicsSectionTitle;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *acceptLabel;
@property (nonatomic, strong) UILabel *cancelLabel;

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
    [self.radioSectionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kSectionSeparator];
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
    
    [self.radioSwitch addTarget:self action:@selector(radioEnabled:) forControlEvents:UIControlEventTouchUpInside];
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
                          withMultiplier:.4];
    self.radioSlider.maximumValue = kMaxRadio;
    [self.radioSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)buildRadio
{
    self.radioLabel = [[UILabel alloc] initForAutoLayout];
    [self.backgroundView addSubview: self.radioLabel];
    [self.radioLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kRightInset];
    [self.radioLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.radioSlider];
    [self.radioLabel autoPinEdge:ALEdgeLeft
                          toEdge:ALEdgeRight
                          ofView:self.radioSlider
                      withOffset:0
                        relation:NSLayoutRelationGreaterThanOrEqual];
    [self.radioLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.radioSwitch];
    [self.radioLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                     forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)buildTopicsSection
{
    [self buildTopicsTitle];
    [self buildSegmentedControl];
    [self buildCollectionView];
    [self buildButtons];
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
    
    self.topicsSectionTitle.text = NSLocalizedString(@"TOPICS", @"Topics");
}

- (void)buildSegmentedControl
{
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Todos", @"Ninguno"]];
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addSubview:self.segmentedControl];
    [self.segmentedControl autoPinEdge:ALEdgeLeft
                                toEdge:ALEdgeRight
                                ofView:self.topicsSectionTitle
                            withOffset:0
                              relation:NSLayoutRelationGreaterThanOrEqual];
    [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.segmentedControl autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.topicsSectionTitle];
    [self.segmentedControl addTarget:self
                              action:@selector(segmentedControlDidChange:)
                    forControlEvents:UIControlEventValueChanged];
}

- (void)buildCollectionView
{
    FiltersViewCollectionLayout *layout = [[FiltersViewCollectionLayout alloc] init];
    self.collectionView = [[SelectedTopicsCollectionView alloc] initWithUICollectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addSubview:self.collectionView];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLineSeparator];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kLineSeparator];
    [self.collectionView autoPinEdge:ALEdgeTop
                              toEdge:ALEdgeBottom
                              ofView:self.topicsSectionTitle
                          withOffset:kLineSeparator];
}

- (void)buildButtons
{
    [self buildAccept];
    [self buildCancel];
}

- (void)buildAccept
{
    self.acceptLabel = [[UILabel alloc] initForAutoLayout];
    self.acceptLabel.text = @"Aceptar";
    [self.backgroundView addSubview:self.acceptLabel];
    [self.acceptLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.collectionView withOffset:kLineSeparator];
    [self.acceptLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kSectionSeparator];
    [self.acceptLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLeftInset];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accept)];
    [self.acceptLabel addGestureRecognizer:tap];
    self.acceptLabel.userInteractionEnabled = YES;
}

- (void)buildCancel
{
    self.cancelLabel = [[UILabel alloc] initForAutoLayout];
    self.cancelLabel.text = @"Cancelar";
    [self.backgroundView addSubview:self.cancelLabel];
    [self.cancelLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLineSeparator];
    [self.cancelLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kRightInset];
    [self.cancelLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.acceptLabel];
    [self.cancelLabel autoPinEdge:ALEdgeLeft
                           toEdge:ALEdgeRight
                           ofView:self.acceptLabel
                       withOffset:kLeftInset
                         relation:NSLayoutRelationGreaterThanOrEqual];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [self.cancelLabel addGestureRecognizer:tap];
    self.cancelLabel.userInteractionEnabled = YES;
}

- (void)modalStyle
{
    [UIView animateWithDuration:.4 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    }];
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.layer.cornerRadius = 30;
    self.backgroundView.clipsToBounds = YES;
    
    UIFont *titleFont = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                       withSize:BeautyCenterTypographySizeD];
    UIFont *radioFont = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                       withSize:BeautyCenterTypographySizeC];
    self.radioSectionTitle.textAlignment = NSTextAlignmentLeft;
    self.radioSectionTitle.font = titleFont;
    self.radioLabel.font = radioFont;
    self.topicsSectionTitle.textAlignment = NSTextAlignmentLeft;
    self.topicsSectionTitle.font = titleFont;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = NO;
    self.acceptLabel.font = radioFont;
    self.acceptLabel.textAlignment = NSTextAlignmentCenter;
    self.cancelLabel.font = radioFont;
    self.cancelLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)sliderDidChange:(id)sender
{
    _radio = ((UISlider*)sender).value;
    self.radioLabel.text = [NSString stringWithFormat:@"%lu km", (unsigned long) _radio];
}

- (void)radioEnabled:(id)sender
{
    _radioEnabled = ((UISwitch*)sender).on;
    [self styleRadiusEnabled:_radioEnabled];
}

- (void)segmentedControlDidChange:(id)sender
{
    NSUInteger index = ((UISegmentedControl*)sender).selectedSegmentIndex;
    [self.delegate didSelectAll:(index == 0)];
    
    self.acceptLabel.enabled = (index != 1);
    ((UIGestureRecognizer*)self.acceptLabel.gestureRecognizers[0]).enabled = self.acceptLabel.enabled;
}

- (void)setRadio:(NSUInteger)radio
{
    _radio = radio;
    [self.radioSlider setValue:radio animated:NO];
    self.radioLabel.text = [NSString stringWithFormat:@"%lu km", (unsigned long) _radio];
}

- (void)setRadioEnabled:(BOOL)radioEnabled
{
    _radioEnabled = radioEnabled;
    [self styleRadiusEnabled:_radioEnabled];
}

- (void)styleRadiusEnabled:(BOOL)enabled
{
    self.radioSectionTitle.enabled = enabled;
    self.radioSwitch.on = enabled;
    self.radioSlider.enabled = enabled;
    self.radioLabel.enabled = enabled;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - MapFiltersViewDelegate

- (void)accept
{
    [self.delegate didTapAccept];
}

- (void)cancel
{
    [self.delegate didTapCancel];
}

@end
