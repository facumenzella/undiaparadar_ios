//
//  PledgePopupView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PledgePopupView.h"
#import "BeautyCenter.h"
#import <PureLayout/PureLayout.h>

static NSString *const kUnderline = @"underline";
static NSString *const kPledge = @"pledgePopup";
static NSString *const kLooking = @"keepLooking";

@interface PledgePopupView ()

@property (nonatomic, strong) UILabel *pledgeTitleLabel;
@property (nonatomic, strong) UIImageView *pledgeTitleUnderline;
@property (nonatomic, strong) UILabel *pledgeSubtitleLabel;
@property (nonatomic, strong) UILabel *pledgeNotificationsLabel;

@property (nonatomic, strong) UIView *buttonsContainer;
@property (nonatomic, strong) UIView *pledgeButtonView;
@property (nonatomic, strong) UILabel *pledgeButtonLabel;
@property (nonatomic, strong) UIView *keepLookingButtonView;
@property (nonatomic, strong) UILabel *keepLookingButtonLabel;

@end

@implementation PledgePopupView

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keepLooking)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    [self buildTitleLabel];
    [self buildSubtitleLabel];
    [self buildNotificationsLabel];
    [self buildButtons];
}

- (void)buildTitleLabel
{
    self.pledgeTitleLabel = [[UILabel alloc] initForAutoLayout];
    self.pledgeTitleLabel.text = @"YO PARTICIPO";
    [self addSubview:self.pledgeTitleLabel];
    
    [self.pledgeTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(16, 0, 0, 0)
                                                    excludingEdge:ALEdgeBottom];
    [self.pledgeTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self buildUnderline];
}

- (void)buildUnderline
{
    self.pledgeTitleUnderline = [[UIImageView alloc] initForAutoLayout];
    self.pledgeTitleUnderline.image = [UIImage imageNamed:kUnderline];
    [self addSubview:self.pledgeTitleUnderline];
    
    [self.pledgeTitleUnderline autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pledgeTitleLabel withOffset:8];
    [self.pledgeTitleUnderline autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                withInset:16];
    [self.pledgeTitleUnderline autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                withInset:16];
    [self.pledgeTitleUnderline setContentHuggingPriority:UILayoutPriorityRequired
                                                 forAxis:UILayoutConstraintAxisVertical];
    
}

- (void)buildSubtitleLabel
{
    self.pledgeSubtitleLabel = [[UILabel alloc] initForAutoLayout];
    self.pledgeSubtitleLabel.text = @"Quieren comprometerte con esta accion?";
    [self addSubview:self.pledgeSubtitleLabel];
    
    [self.pledgeSubtitleLabel autoPinEdge:ALEdgeTop
                                   toEdge:ALEdgeBottom
                                   ofView:self.pledgeTitleUnderline
                               withOffset:16];
    [self.pledgeSubtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                               withInset:16];
    [self.pledgeSubtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                               withInset:16];
    [self.pledgeSubtitleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                forAxis:UILayoutConstraintAxisVertical];
}

- (void)buildNotificationsLabel
{
    self.pledgeNotificationsLabel = [[UILabel alloc] initForAutoLayout];
    self.pledgeNotificationsLabel.text = @"Te enviaremos notificaciones cada vez que se actualice informacion sobre la campaña";
    [self addSubview:self.pledgeNotificationsLabel];
    [self.pledgeNotificationsLabel autoPinEdge:ALEdgeTop
                                        toEdge:ALEdgeBottom
                                        ofView:self.pledgeSubtitleLabel
                                    withOffset:8];
    [self.pledgeNotificationsLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                                    withInset:16];
    [self.pledgeNotificationsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                                    withInset:16];
    [self.pledgeNotificationsLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                     forAxis:UILayoutConstraintAxisVertical];
}

- (void)buildButtons
{
    self.buttonsContainer = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.buttonsContainer];
    [self.buttonsContainer autoPinEdge:ALEdgeTop
                                toEdge:ALEdgeBottom
                                ofView:self.pledgeNotificationsLabel
                            withOffset:16];
    [self.buttonsContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                            withInset:16];
    [self.buttonsContainer autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.buttonsContainer setContentHuggingPriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisVertical];
    [self buildPledgeButton];
    [self buildKeepLookingButton];
}

- (void)buildPledgeButton
{
    self.pledgeButtonView = [[UIView alloc] initForAutoLayout];
    [self.buttonsContainer addSubview:self.pledgeButtonView];
    [self.pledgeButtonView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    
    UIButton *pledge = [[UIButton alloc] initForAutoLayout];
    [pledge setBackgroundImage:[UIImage imageNamed:kPledge] forState:UIControlStateNormal];
    [self.pledgeButtonView addSubview:pledge];
    [pledge autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [pledge autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [pledge autoSetDimension:ALDimensionWidth toSize:69];
    [pledge autoSetDimension:ALDimensionHeight toSize:70];
    [pledge addTarget:self action:@selector(pledge) forControlEvents:UIControlEventTouchUpInside];
    
    self.pledgeButtonLabel = [[UILabel alloc] initForAutoLayout];
    [self.pledgeButtonView addSubview:self.pledgeButtonLabel];
    [self.pledgeButtonLabel setContentHuggingPriority:UILayoutPriorityRequired
                                              forAxis:UILayoutConstraintAxisVertical];
    self.pledgeButtonLabel.text = NSLocalizedString(@"I_COMMIT", @"Me Comprometo");
    [self.pledgeButtonLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pledge];
    [self.pledgeButtonLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.pledgeButtonLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                            forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)buildKeepLookingButton
{
    self.keepLookingButtonView = [[UIView alloc] initForAutoLayout];
    [self.buttonsContainer addSubview:self.keepLookingButtonView];
    [self.keepLookingButtonView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [self.keepLookingButtonView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.pledgeButtonView withOffset:8];
    
    UIButton *keepLooking = [[UIButton alloc] initForAutoLayout];
    [keepLooking setBackgroundImage:[UIImage imageNamed:kLooking] forState:UIControlStateNormal];
    [self.keepLookingButtonView addSubview:keepLooking];
    [keepLooking autoSetDimension:ALDimensionWidth toSize:69];
    [keepLooking autoSetDimension:ALDimensionHeight toSize:70];
    [keepLooking autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [keepLooking autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [keepLooking addTarget:self action:@selector(keepLooking) forControlEvents:UIControlEventTouchUpInside];
    
    self.keepLookingButtonLabel = [[UILabel alloc] initForAutoLayout];
    [self.keepLookingButtonView addSubview:self.keepLookingButtonLabel];
    [self.keepLookingButtonLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                   forAxis:UILayoutConstraintAxisVertical];
    self.keepLookingButtonLabel.text = NSLocalizedString(@"KEEP_LOOKING", @"Seguir buscando");
    [self.keepLookingButtonLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:keepLooking];
    [self.keepLookingButtonLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.keepLookingButtonLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                                 forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)styleSubviews
{
    self.pledgeTitleLabel.backgroundColor = [UIColor clearColor];
    self.pledgeTitleLabel.textColor = [UIColor redColor];
    self.pledgeTitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleMedium
                                                                withSize:BeautyCenterTypographySizeE];
    self.pledgeTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.pledgeSubtitleLabel.backgroundColor = [UIColor clearColor];
    self.pledgeSubtitleLabel.numberOfLines = 2;
    self.pledgeSubtitleLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleBold
                                                                   withSize:BeautyCenterTypographySizeB];
    self.pledgeSubtitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.pledgeNotificationsLabel.backgroundColor = [UIColor clearColor];
    self.pledgeNotificationsLabel.numberOfLines = 3;
    self.pledgeNotificationsLabel.textAlignment = NSTextAlignmentCenter;
    self.pledgeNotificationsLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                        withSize:BeautyCenterTypographySizeA];
    
    self.pledgeButtonView.backgroundColor = [UIColor clearColor];
    self.pledgeButtonLabel.textAlignment = NSTextAlignmentCenter;
    self.pledgeButtonLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                 withSize:BeautyCenterTypographySizeA];
    self.keepLookingButtonView.backgroundColor = [UIColor clearColor];
    self.keepLookingButtonLabel.textAlignment = NSTextAlignmentCenter;
    self.keepLookingButtonLabel.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                      withSize:BeautyCenterTypographySizeA];
}

- (void)modalStyle
{
    [UIView animateWithDuration:.4 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    }];
}

#pragma mark - PledgeViewDelegate

- (void)pledge
{
    [self.delegate pledge];
}

- (void)keepLooking
{
    [UIView animateWithDuration:.4 animations: ^{
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL completed) {
        [self.delegate keepLooking];
    }];
}

@end
