//
//  ConfirmPositiveActionPopupView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ConfirmPledgePopupView.h"
#import "BeautyCenter.h"
#import <PureLayout/PureLayout.h>

static NSString *const kUnderline = @"underline";

@interface ConfirmPledgePopupView ()

@property (nonatomic, strong) UILabel *confirmTitleLabel;
@property (nonatomic, strong) UIImageView *titleUnderline;
@property (nonatomic, strong) UILabel *confirmationSubtitle;
@property (nonatomic, strong) UILabel *confirmationAddtionalInfo;
@property (nonatomic, strong) UITextField *codeTextfield;
@property (nonatomic, strong) UILabel *confirmationButton;

@end

@implementation ConfirmPledgePopupView

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
    [self buildConfirmationAddtionalInfo];
    [self buildCodeTextfield];
    [self buildConfirmationButton];
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
                                         ofView:self.confirmationSubtitle
                                     withOffset:8];
    [self.confirmationAddtionalInfo autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                     withInset:16];
    [self.confirmationAddtionalInfo autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                     withInset:16];
}

- (void)buildCodeTextfield
{
    self.codeTextfield = [[UITextField alloc] initForAutoLayout];
    [self addSubview:self.codeTextfield];
    self.codeTextfield.placeholder = @"Codigo";
    [self.codeTextfield autoPinEdge:ALEdgeTop
                                  toEdge:ALEdgeBottom
                                  ofView:self.confirmationAddtionalInfo
                              withOffset:8];
    [self.codeTextfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:48];
    [self.codeTextfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:48];

}

- (void)buildConfirmationButton
{
    self.confirmationButton = [[UILabel alloc] initForAutoLayout];
    self.confirmationButton.text = @"Confirmar";
    [self addSubview:self.confirmationButton];
    [self.confirmationButton autoPinEdge:ALEdgeTop
                                  toEdge:ALEdgeBottom
                                  ofView:self.codeTextfield
                              withOffset:8];
    [self.confirmationButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:48];
    [self.confirmationButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:48];
    [self.confirmationButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8 relation:NSLayoutRelationGreaterThanOrEqual];
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
    self.confirmationButton.textColor = [UIColor whiteColor];
    self.confirmationButton.textAlignment = NSTextAlignmentCenter;
    self.confirmationButton.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                  withSize:BeautyCenterTypographySizeC];
}

@end
