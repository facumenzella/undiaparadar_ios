//
//  TapToRetryView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/9/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TapToRetryView.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

static NSString *const kBackground = @"Splash";

@interface TapToRetryView ()

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *undiaparadarImageView;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UILabel *noConnectionLabel;
@property (nonatomic, strong) UILabel *tapToRetryLabel;

@end

@implementation TapToRetryView

- (instancetype)init
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
    [self buildBackground];
    [self buildSeparator];
    [self buildUDPDImageView];
    [self buildTapToRetryLabel];
}

- (void)buildBackground
{
    self.background = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:self.background];
    self.background.image = [UIImage imageNamed:kBackground];
    [self.background autoPinEdgesToSuperviewEdges];
}

- (void)buildUDPDImageView
{
    self.undiaparadarImageView = [[UIImageView alloc] initForAutoLayout];
    [self.background addSubview:self.undiaparadarImageView];
    [self.undiaparadarImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.separator withOffset:0];
    [self.undiaparadarImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
}

- (void)buildSeparator
{
    self.separator = [[UIView alloc] initForAutoLayout];
    [self.background addSubview:self.separator];
    [self.separator autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.separator autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.separator autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.separator autoSetDimension:ALDimensionHeight toSize:8];
}

- (void)buildTapToRetryLabel
{
    self.tapToRetryLabel = [[UILabel alloc] initForAutoLayout];
    [self.background addSubview:self.tapToRetryLabel];
    [self.tapToRetryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.separator];
    [self.tapToRetryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.tapToRetryLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    self.tapToRetryLabel.text = NSLocalizedString(@"NO_CONNECTION", @"No posee conexion a internet");
}

- (void)buildNoConnectionLabel
{
    self.noConnectionLabel = [[UILabel alloc] initForAutoLayout];
    [self.background addSubview:self.noConnectionLabel];
    [self.noConnectionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tapToRetryLabel];
    [self.noConnectionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.noConnectionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    self.tapToRetryLabel.text = NSLocalizedString(@"TAP_TO_RETRY", @"Aprete para recargar la pagina");
}

- (void)styleSubviews
{
    self.tapToRetryLabel.backgroundColor = [UIColor clearColor];
    self.tapToRetryLabel.numberOfLines = 3;
    self.tapToRetryLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                               withSize:BeautyCenterTypographySizeD];
}

@end
