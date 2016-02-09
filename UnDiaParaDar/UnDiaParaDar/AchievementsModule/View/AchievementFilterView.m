//
//  AchievementFilter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementFilterView.h"
#import "BeautyCenter.h"
#import <PureLayout/PureLayout.h>

@interface AchievementFilterView ()

@property (nonatomic, strong) UILabel *quantityLabel;
@property (nonatomic, strong) UILabel *categoryLabel;

@end

@implementation AchievementFilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)populateWithQuantity:(NSUInteger)quantity withCategory:(NSString*)category
{
    self.quantityLabel.text = [NSString stringWithFormat:@"%d", quantity];
    self.categoryLabel.text = category;
}

- (void)buildSubviews
{
    [self buildQuantityLabel];
    [self buildCategoryLabel];
}

- (void)buildQuantityLabel
{
    self.quantityLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:self.quantityLabel];
    [self.quantityLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    self.quantityLabel.text = @"0";
}

- (void)buildCategoryLabel
{
    self.categoryLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:self.categoryLabel];
    [self.categoryLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.categoryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.quantityLabel];
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.quantityLabel.textAlignment = NSTextAlignmentCenter;
    self.quantityLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleBold
                                                             withSize:BeautyCenterTypographySizeB];
    
    self.categoryLabel.textAlignment = NSTextAlignmentCenter;
    self.categoryLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                             withSize:BeautyCenterTypographySizeA];
}

- (void)setActive:(BOOL)active
{
    [self styleActive:active];
}

- (void)styleActive:(BOOL)active
{
    if (active) {
        self.quantityLabel.textColor = [BeautyCenter beautyCenterColor:BeautyCenterColorTurquese];
        self.categoryLabel.textColor = [BeautyCenter beautyCenterColor:BeautyCenterColorTurquese];
        return;
    }
    self.quantityLabel.textColor = [UIColor blackColor];
    self.categoryLabel.textColor = [UIColor blackColor];
}


@end
