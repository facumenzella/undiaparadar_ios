//
//  LoadingView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "LoadingView.h"
#import <PureLayout/PureLayout.h>

#import "FMActivityIndicatorView.h"

@interface LoadingView ()

@property (nonatomic, strong) FMActivityIndicatorView *activityIndicatorView;

@end

@implementation LoadingView

-(instancetype)init
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
    self.activityIndicatorView = [[FMActivityIndicatorView alloc] initWithImage: [UIImage imageNamed:@"activity"]];
    [self addSubview: self.activityIndicatorView];
    
    [self.activityIndicatorView autoCenterInSuperview];
}

- (void)styleSubviews
{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
}

#pragma mark - ModalViewProtocol

-(void)startAnimating
{
    [self.activityIndicatorView startAnimating];
}

-(void)endAnimating
{
    [self.activityIndicatorView stopAnimating];
}

@end
