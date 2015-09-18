//
//  PositiveActionDetailView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionDetailView.h"

#import <PureLayout/PureLayout.h>

@interface PositiveActionDetailView ()

@property (nonatomic, strong) UIView *mainHeaderView;
@property (nonatomic, strong) UILabel *positiveActionTitle;
@property (nonatomic, strong) UIImageView *colorBandImageView;
@property (nonatomic, strong) UITextView *positiveActionDescription;

@end

@implementation PositiveActionDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _state = PositiveActionsWithMapViewStateMap;
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildMainHeader];
}

- (void)buildMainHeader
{
    self.mainHeaderView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.mainHeaderView];
//    [self.mainHeaderView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.mainHeaderView autoPinEdgesToSuperviewEdges];
    
    [self buildPositiveActionTitle];
    [self buildTitleUnderline];
    [self buildPositiveActionDescription];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UILabel alloc] initForAutoLayout];
    [self.mainHeaderView addSubview: self.positiveActionTitle];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    
    // TODO MOCK TEXT
    self.positiveActionTitle.text = @"Sumate a nuestra campaña \"NO SELFIE\"";
}

- (void)buildTitleUnderline
{
    self.colorBandImageView = [[UIImageView alloc] initForAutoLayout];
    UIImage *colorBand = [UIImage imageNamed:@"color_band"];
    [self.colorBandImageView setImage: colorBand];
    
    [self.mainHeaderView addSubview: self.colorBandImageView];
    [self.colorBandImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView: self.positiveActionTitle withOffset:8];
    [self.colorBandImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.colorBandImageView autoMatchDimension:ALDimensionWidth
                                    toDimension:ALDimensionWidth
                                         ofView:self.positiveActionTitle];
}

- (void)buildPositiveActionDescription
{
    self.positiveActionDescription = [[UITextView alloc] initForAutoLayout];
    [self.mainHeaderView addSubview: self.positiveActionDescription];
    [self.positiveActionDescription autoPinEdge:ALEdgeTop
                                         toEdge:ALEdgeBottom
                                         ofView:self.colorBandImageView
                                     withOffset:8];
    [self.positiveActionDescription autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionDescription autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    self.positiveActionDescription.scrollEnabled = NO;
    self.positiveActionDescription.editable = NO;
    // TODO MOCK TEXT
    self.positiveActionDescription.text = @"Te invitamos a que cuando dones sangre te saques una foto como esta y que despues compartas la foto en tus redes sociales usando el hashtag \'#NOSelfie\'";
}

- (void)styleSubviews
{
    [self setState:_state];
}

- (void)styleSubviewsOn
{
    [self.mainHeaderView setBackgroundColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
    
    [self.positiveActionTitle setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionTitle setTextColor: [UIColor whiteColor]];
    
    [self.positiveActionDescription setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionDescription setTextColor: [UIColor whiteColor]];
    [self.positiveActionDescription setBackgroundColor: [UIColor clearColor]];
}

- (void)styleSubviewsOff
{
    [self.mainHeaderView setBackgroundColor: [UIColor whiteColor]];
    
    [self.positiveActionTitle setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionTitle setTextColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
    
    [self.positiveActionDescription setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionDescription setTextColor: [UIColor whiteColor]];
    [self.positiveActionDescription setBackgroundColor: [UIColor clearColor]];
}

- (void)setState:(PositiveActionsWithMapViewState)state
{
    _state = state;
    switch (_state) {
        case PositiveActionsWithMapViewStateDescription:
            [self styleSubviewsOn];
            break;
        case PositiveActionsWithMapViewStateMap:
            [self styleSubviewsOff];
            break;
        default:
            NSLog(@"Holy shit, wrong state in PositiveActionDetailView");
            break;
    }
}

@end
