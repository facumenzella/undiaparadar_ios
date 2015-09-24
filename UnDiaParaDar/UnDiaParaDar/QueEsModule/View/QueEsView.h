//
//  QueEsView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QueEsPresenter;

@interface QueEsView : UIWebView

- (instancetype)initWithQueEs:(QueEsPresenter*)queEs;

@end
