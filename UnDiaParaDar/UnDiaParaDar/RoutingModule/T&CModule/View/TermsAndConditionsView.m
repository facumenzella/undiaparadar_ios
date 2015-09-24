//
//  TermsAndConditionsView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TermsAndConditionsView.h"
#import "TermsAndConditionsPresenter.h"

@interface TermsAndConditionsView ()

@property (nonatomic, strong) TermsAndConditionsPresenter *presenter;

@end

@implementation TermsAndConditionsView

- (instancetype)initWithTermsAndConditions:(TermsAndConditionsPresenter*)termsAndConditions
{
    self = [super init];
    if (self) {
        self.presenter = termsAndConditions;
        [self buildSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self loadHTMLString:self.presenter.htmlTermsAndConditions baseURL:nil];
}

@end
