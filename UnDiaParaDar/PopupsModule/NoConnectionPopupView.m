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
    self = [super initWithInsets:UIEdgeInsetsMake(80, 32, 80, 32)];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(understood)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    [self buildTitleLabel];
    [self buildSubtitleLabel];
    [self buildUnderstood];
}

- (void)buildTitleLabel
{
    self.noConnectionTitleLabel = [[UILabel alloc] initForAutoLayout];
    self.noConnectionTitleLabel.text = @"Lo sentimos";
    [self addSubview:self.noConnectionTitleLabel];
    
    [self.noConnectionTitleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                   forAxis:UILayoutConstraintAxisVertical];
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
    [self.noConnectionTitleUnderline setContentHuggingPriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisVertical];
}

- (void)buildSubtitleLabel
{
    self.noConnectionSubtitleLabel = [[UILabel alloc] initForAutoLayout];
    self.noConnectionSubtitleLabel.text = @"#UnDiaParaDar necesita conexión para brindarte una mejor experiencia.\n\nPor favor revisa tu conexión a internet e intenta nuevamente.";
    [self addSubview:self.noConnectionSubtitleLabel];
    
    [self.noConnectionSubtitleLabel autoPinEdge:ALEdgeTop
                                         toEdge:ALEdgeBottom
                                         ofView:self.noConnectionTitleUnderline withOffset:16];
    [self.noConnectionSubtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                     withInset:16];
    [self.noConnectionSubtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                     withInset:16];
    [self.noConnectionSubtitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                                    forAxis:UILayoutConstraintAxisVertical];
}

- (void)buildUnderstood
{
    self.noConnectionUnderstood = [[UILabel alloc] initForAutoLayout];
    self.noConnectionUnderstood.text = @"Entendido";
    [self addSubview:self.noConnectionUnderstood];
    
    [self.noConnectionUnderstood autoPinEdge:ALEdgeTop
                                      toEdge:ALEdgeBottom
                                      ofView:self.noConnectionSubtitleLabel
                                  withOffset:16];
    [self.noConnectionUnderstood autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.noConnectionUnderstood autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.noConnectionUnderstood autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                                  withInset:16];
    [self.noConnectionUnderstood setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                                 forAxis:UILayoutConstraintAxisVertical];
    
    
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
    self.noConnectionSubtitleLabel.numberOfLines = 0;
    self.noConnectionSubtitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                         withSize:BeautyCenterTypographySizeC];
    self.noConnectionSubtitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.noConnectionUnderstood.textAlignment = NSTextAlignmentCenter;
    self.noConnectionUnderstood.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleBold
                                                                      withSize:BeautyCenterTypographySizeB];
    self.noConnectionUnderstood.textColor = [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed];
}

- (void)modalStyle
{
    [UIView animateWithDuration:.4 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    }];
}

- (void)understood
{
    [UIView animateWithDuration:.4 animations: ^{
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL completed) {
        [self.delegate understood];
    }];
}
@end
