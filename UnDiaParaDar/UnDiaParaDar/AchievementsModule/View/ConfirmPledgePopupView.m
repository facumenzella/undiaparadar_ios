//
//  ConfirmPositiveActionPopupView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ConfirmPledgePopupView.h"
#import "BeautyCenter.h"
#import "UDPDTextField.h"
#import <PureLayout/PureLayout.h>

static NSString *const kUnderline = @"underline";

@interface ConfirmPledgePopupView ()

@property (nonatomic, strong) UILabel *confirmTitleLabel;
@property (nonatomic, strong) UIImageView *titleUnderline;
@property (nonatomic, strong) UILabel *confirmationSubtitle;
@property (nonatomic, strong) UILabel *confirmationAddtionalInfo;
@property (nonatomic, strong) UDPDTextField *codeTextfield;
@property (nonatomic, strong) UIView *confirmationButton;
@property (nonatomic, strong) UILabel *confirmationLabel;

@end

@implementation ConfirmPledgePopupView

- (instancetype)init
{
    self = [super initWithInsets:UIEdgeInsetsMake(80, 32, 120, 32)];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    [self buildTitleLabel];
    [self buildSubtitleLabel];
    [self buildCodeTextfield];
    [self buildConfirmationButton];
    [self buildConfirmationAddtionalInfo];
}

- (void)buildTitleLabel
{
    self.confirmTitleLabel = [[UILabel alloc] initForAutoLayout];
    self.confirmTitleLabel.text = @"YO PARTICIPO";
    [self addSubview:self.confirmTitleLabel];
    
    [self.confirmTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(16, 0, 0, 0)
                                                     excludingEdge:ALEdgeBottom];
    [self buildUnderline];
}

- (void)buildUnderline
{
    self.titleUnderline = [[UIImageView alloc] initForAutoLayout];
    self.titleUnderline.image = [UIImage imageNamed:kUnderline];
    [self addSubview:self.titleUnderline];
    
    [self.titleUnderline autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.confirmTitleLabel withOffset:8];
    [self.titleUnderline autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                          withInset:16];
    [self.titleUnderline autoPinEdgeToSuperviewEdge:ALEdgeRight
                                          withInset:16];
}

- (void)buildSubtitleLabel
{
    self.confirmationSubtitle = [[UILabel alloc] initForAutoLayout];
    self.confirmationSubtitle.text = @"Ingrese el código proporcionado al realizar la acción positiva";
    [self addSubview:self.confirmationSubtitle];
    
    [self.confirmationSubtitle autoPinEdge:ALEdgeTop
                                    toEdge:ALEdgeBottom
                                    ofView:self.titleUnderline
                                withOffset:16];
    [self.confirmationSubtitle autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                withInset:16];
    [self.confirmationSubtitle autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                withInset:16];
}

- (void)buildConfirmationAddtionalInfo
{
    self.confirmationAddtionalInfo = [[UILabel alloc] initForAutoLayout];
    self.confirmationAddtionalInfo.text = @"";
    [self addSubview:self.confirmationAddtionalInfo];
    [self.confirmationAddtionalInfo autoPinEdge:ALEdgeTop
                                         toEdge:ALEdgeBottom
                                         ofView:self.confirmationButton
                                     withOffset:8];
    [self.confirmationAddtionalInfo autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                     withInset:16];
    [self.confirmationAddtionalInfo autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                     withInset:16];
    [self.confirmationAddtionalInfo autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                                     withInset:16
                                                      relation:NSLayoutRelationGreaterThanOrEqual];
    self.confirmationAddtionalInfo.text = @"Código inválido";
    self.confirmationAddtionalInfo.alpha = 0;
}

- (void)buildCodeTextfield
{
    self.codeTextfield = [[UDPDTextField alloc] initForAutoLayout];
    [self addSubview:self.codeTextfield];
    [self.codeTextfield autoPinEdge:ALEdgeTop
                             toEdge:ALEdgeBottom
                             ofView:self.confirmationSubtitle
                         withOffset:16];
    [self.codeTextfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:48];
    [self.codeTextfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:48];
    [self.codeTextfield autoSetDimension:ALDimensionHeight toSize:48];
}

- (void)buildConfirmationButton
{
    self.confirmationButton = [[UIView alloc] initForAutoLayout];
    self.confirmationButton.userInteractionEnabled = YES;
    [self addSubview:self.confirmationButton];
    [self.confirmationButton autoPinEdge:ALEdgeTop
                                  toEdge:ALEdgeBottom
                                  ofView:self.codeTextfield
                              withOffset:8];
    [self.confirmationButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:48];
    [self.confirmationButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:48];
    [self.confirmationButton autoSetDimension:ALDimensionHeight toSize:48];
    
    self.confirmationLabel = [[UILabel alloc] initForAutoLayout];
    [self.confirmationButton addSubview:self.confirmationLabel];
    [self.confirmationLabel autoPinEdgesToSuperviewEdges];
    self.confirmationLabel.text = @"Confirmar";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(confirm)];
    [self.confirmationButton addGestureRecognizer:tap];
}

- (void)styleSubviews
{
    self.confirmTitleLabel.backgroundColor = [UIColor clearColor];
    self.confirmTitleLabel.textColor = [UIColor redColor];
    self.confirmTitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleMedium
                                                                 withSize:BeautyCenterTypographySizeE];
    self.confirmTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.confirmationSubtitle.backgroundColor = [UIColor clearColor];
    self.confirmationSubtitle.numberOfLines = 0;
    self.confirmationSubtitle.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleBold
                                                                    withSize:BeautyCenterTypographySizeB];
    self.confirmationSubtitle.textAlignment = NSTextAlignmentCenter;
    
    self.confirmationAddtionalInfo.backgroundColor = [UIColor clearColor];
    self.confirmationAddtionalInfo.numberOfLines = 3;
    self.confirmationAddtionalInfo.textAlignment = NSTextAlignmentCenter;
    self.confirmationAddtionalInfo.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                         withSize:BeautyCenterTypographySizeA];
    
    self.codeTextfield.textAlignment = NSTextAlignmentCenter;
    self.codeTextfield.layer.borderWidth = 1.5f;
    self.codeTextfield.layer.borderColor = [BeautyCenter beautyCenterColor:BeautyCenterColorGrey].CGColor;
    
    self.confirmationButton.backgroundColor = [BeautyCenter beautyCenterColor:BeautyCenterColorTurquese];
    self.confirmationLabel.textColor = [UIColor whiteColor];
    self.confirmationLabel.textAlignment = NSTextAlignmentCenter;
    self.confirmationLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                 withSize:BeautyCenterTypographySizeC];
    self.confirmationLabel.backgroundColor = [UIColor clearColor];
}

- (void)confirm
{
    [self.codeTextfield resignFirstResponder];
    [self.delegate confirmWithCode:self.codeTextfield.text];
}

- (void)dismiss
{
    [UIView animateWithDuration:.4 animations:^{
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self.delegate dismiss];
    }];
}

- (void)modalStyle
{
    [UIView animateWithDuration:.4 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    }];
}

- (void)setError:(BOOL)error
{
    [self.codeTextfield setError:error];
    if (error) {
        self.confirmationAddtionalInfo.alpha = 1;
        [UIView animateWithDuration:1 animations:^{
            self.confirmationAddtionalInfo.alpha = 0;
        } completion:^(BOOL finished) {
            [self.codeTextfield setError:!error];
        }];
    }
}

@end
