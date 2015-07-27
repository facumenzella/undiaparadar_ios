//
//  SpotifyLikeView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SpotifyLikeView.h"
#import "SpotifyLikeViewPresenter.h"
#import <UIView+AutoLayout.h>


@interface SpotifyLikeView ()

@property (nonatomic, strong) UIView *overview;
@property (nonatomic, strong) UIImageView *userProfilePicture;
@property (nonatomic, strong) UIImageView *profileTimelinePicture;
@property (nonatomic, strong) UIView *userInformationView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SpotifyLikeViewPresenter *presenter;

@end

@implementation SpotifyLikeView

#pragma mark - SpotifyLikeView

-(instancetype)initWithPresenter:(SpotifyLikeViewPresenter*)presenter
{
    self = [super initForAutoLayout];
    if (self) {
        self.presenter = presenter;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self buildSubviews];
    }
    return self;
}

#pragma mark - Subviews

- (void)buildSubviews
{
    [self buildUserInformationView];
    
}

- (void)buildUserInformationView
{
    self.userInformationView = [[UIView alloc] initForAutoLayout];
    [self addSubview:self.userInformationView];
    [self.userInformationView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.userInformationView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.userInformationView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];

    self.userProfilePicture = [[UIImageView alloc] initForAutoLayout];
    [self.userProfilePicture setContentMode:UIViewContentModeScaleAspectFill];
    [self.userProfilePicture setClipsToBounds:YES];
    [self.userProfilePicture.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.userProfilePicture.layer setBorderWidth:2.0];
    [self.userProfilePicture.layer setCornerRadius:10];
    
    [self.userInformationView addSubview:self.userProfilePicture];
    [self.userInformationView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.userInformationView autoSetDimension:ALAxisHorizontal toSize:10];
    [self.userInformationView autoSetDimension:ALAxisVertical toSize:10];
    [self.userInformationView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.userInformationView];
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
