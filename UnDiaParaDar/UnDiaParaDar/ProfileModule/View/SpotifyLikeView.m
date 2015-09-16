//
//  SpotifyLikeView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SpotifyLikeView.h"
#import "SpotifyLikeViewPresenter.h"
#import <PureLayout/PureLayout.h>

@interface SpotifyLikeView ()

@property (nonatomic, strong) UIView *overview;
@property (nonatomic, strong) UIImageView *profileUserImageView;
@property (nonatomic, strong) UIImageView *profileTimelineImageView;
@property (nonatomic, strong) UIView *profileUserInformationView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SpotifyLikeViewPresenter *presenter;

@end

@implementation SpotifyLikeView

#pragma mark - SpotifyLikeView

-(instancetype)initWithPresenter:(SpotifyLikeViewPresenter*)presenter
{
    self = [super init];
    if (self) {
        self.presenter = presenter;
        [self buildSubviews];
    }
    return self;
}

#pragma mark - Subviews

- (void)buildSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self buildUserInformationView];
}

- (void)buildUserInformationView
{
    self.profileUserInformationView = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.profileUserInformationView];
    [self.profileUserInformationView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.profileUserInformationView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.profileUserInformationView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    self.profileTimelineImageView = [[UIImageView alloc] initForAutoLayout];
    [self.profileUserInformationView addSubview: self.profileTimelineImageView];
    [self.profileTimelineImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.profileTimelineImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.profileTimelineImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.profileTimelineImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [NSLayoutConstraint constraintWithItem:self.profileTimelineImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem: self.profileTimelineImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0f
                                  constant:0];
    [self.profileTimelineImageView setImage: self.presenter.profileTimelineImage];
    
    self.profileUserImageView = [[UIImageView alloc] initForAutoLayout];
    [self.profileUserInformationView addSubview:self.profileUserImageView];
    [self.profileUserImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.profileUserImageView setClipsToBounds:YES];
    [self.profileUserImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.profileUserImageView.layer setBorderWidth:2.0];
    [self.profileUserImageView.layer setCornerRadius:20];
    
    [self.profileUserImageView autoSetDimension:ALDimensionWidth toSize:104];
    [self.profileUserImageView autoSetDimension:ALDimensionHeight toSize:104];
    [self.profileUserImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.profileUserImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [self.profileUserImageView setImage: self.presenter.profileUserImage];
}

#pragma mark - UIViewGeometry

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = {_overview.frame.origin, {
        _overview.frame.size.width, _overview.frame.size.height-_tableView.contentOffset.y
    }
    };
    
    if (CGRectContainsPoint(rect, point)) {
        return [_overview hitTest:point withEvent:event];;
    }
    
    return [super hitTest:point withEvent:event];
}

@end
