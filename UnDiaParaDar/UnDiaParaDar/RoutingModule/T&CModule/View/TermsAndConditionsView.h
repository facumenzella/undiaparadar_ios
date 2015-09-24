//
//  TermsAndConditionsView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TermsAndConditionsPresenter;

@interface TermsAndConditionsView : UIWebView

- (instancetype)initWithTermsAndConditions:(TermsAndConditionsPresenter*)termsAndConditions;

@end
