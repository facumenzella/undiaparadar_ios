//
//  QueEsView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UDPDWebView.h"

@class QueEsPresenter;

@interface QueEsView : UDPDWebView

- (instancetype)initWithQueEs:(QueEsPresenter*)queEs;

@end
