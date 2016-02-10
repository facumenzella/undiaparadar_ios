//
//  TermsAndConditionsView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UDPDWebView.h"

@class TermsAndConditionsPresenter;

@interface TermsAndConditionsView : UDPDWebView

- (instancetype)initWithTermsAndConditions:(TermsAndConditionsPresenter*)termsAndConditions;

@end
