//
//  QueEsView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "QueEsView.h"
#import "QueEsPresenter.h"

@interface QueEsView ()

@property (nonatomic, strong) QueEsPresenter *presenter;

@end

@implementation QueEsView

- (instancetype)initWithQueEs:(QueEsPresenter*)queEs
{
    self = [super init];
    if (self) {
        self.presenter = queEs;
        self.delegate = self;
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self loadHTMLString:self.presenter.htmlTermsAndConditions baseURL:nil];
}

@end
