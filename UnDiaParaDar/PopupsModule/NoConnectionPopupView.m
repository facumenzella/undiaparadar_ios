//
//  NoConnectionPopupView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "NoConnectionPopupView.h"
#import "BeautyCenter.h"
#import <PureLayout/PureLayout.h>

static NSString *const kUnderline = @"underline";

@interface NoConnectionPopupView()

@property (nonatomic, strong) UILabel *noConnectionTitleLabel;
@property (nonatomic, strong) UIImageView *noConnectionTitleUnderline;
@property (nonatomic, strong) UILabel *noConnectionSubtitleLabel;
@property (nonatomic, strong) UILabel *noConnectionUnderstood;

@end

@implementation NoConnectionPopupView

- (instancetype)init
{
    self = [super initWithInsets:UIEdgeInsetsMake(80, 32, 160, 32)];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildTitleLabel];
    [self buildSubtitleLabel];
    [self buildUnderstood];
}

- (void)buildTitleLabel
{
    self.noConnectionTitleLabel = [[UILabel alloc] initForAutoLayout];
    self.noConnectionTitleLabel.text = @"Lo sentimos";
    [self addSubview:self.noConnectionTitleLabel];
    
    [self.noConnectionTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(16, 0, 0, 0)
                                                          excludingEdge:ALEdgeBottom];
    [self buildUnderline];
}

- (void)buildUnderline
{
    self.noConnectionTitleUnderline = [[UIImageView alloc] initForAutoLayout];
    self.noConnectionTitleUnderline.image = [UIImage imageNamed:kUnderline];
    [self addSubview:self.noConnectionTitleUnderline];
    
    [self.noConnectionTitleUnderline autoPinEdge:ALEdgeTop
                                          toEdge:ALEdgeBottom
                                          ofView:self.noConnectionTitleLabel withOffset:8];
    [self.noConnectionTitleUnderline autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                      withInset:16];
    [self.noConnectionTitleUnderline autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                      withInset:16];
}

- (void)buildSubtitleLabel
{
    self.noConnectionSubtitleLabel = [[UILabel alloc] initForAutoLayout];
    self.noConnectionSubtitleLabel.text = @"Parece que te has quedado sin conexión.\n#UnDiaParaDar necesita conexión para brindarte una mejor experiencia.]nPor favor chequea tu conexión a internet e intenta nuevamente.";
    [self addSubview:self.noConnectionSubtitleLabel];
    
    [self.noConnectionSubtitleLabel autoPinEdge:ALEdgeTop
                                         toEdge:ALEdgeBottom
                                         ofView:self.noConnectionTitleUnderline withOffset:16];
    [self.noConnectionSubtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                     withInset:16];
    [self.noConnectionSubtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                     withInset:16];
}

- (void)buildUnderstood
{
    self.noConnectionUnderstood = [[UILabel alloc] initForAutoLayout];
    self.noConnectionUnderstood.text = @"Entendido";
    [self addSubview:self.noConnectionUnderstood];
    
    [self.noConnectionUnderstood autoPinEdge:ALEdgeTop
                                      toEdge:ALEdgeBottom
                                      ofView:self.noConnectionSubtitleLabel
                                  withOffset:16
                                    relation:NSLayoutRelationGreaterThanOrEqual];
    [self.noConnectionUnderstood autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.noConnectionUnderstood autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.noConnectionUnderstood autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                                  withInset:16];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(understood)];
    [self.noConnectionUnderstood addGestureRecognizer:tap];
    self.noConnectionUnderstood.userInteractionEnabled = YES;
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor clearColor];
    self.noConnectionTitleLabel.backgroundColor = [UIColor clearColor];
    self.noConnectionTitleLabel.textColor = [UIColor redColor];
    self.noConnectionTitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleMedium
                                                                      withSize:BeautyCenterTypographySizeE];
    self.noConnectionTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.noConnectionSubtitleLabel.backgroundColor = [UIColor clearColor];
    self.noConnectionSubtitleLabel.numberOfLines = 6;
    self.noConnectionSubtitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                         withSize:BeautyCenterTypographySizeC];
    self.noConnectionSubtitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.noConnectionUnderstood.textAlignment = NSTextAlignmentCenter;
    self.noConnectionUnderstood.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                 withSize:BeautyCenterTypographySizeD];
}

- (void)understood
{
    [self.delegate understood];
}
@end
