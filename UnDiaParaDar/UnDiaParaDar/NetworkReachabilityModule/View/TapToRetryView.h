//
//  TapToRetryView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/9/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapToRetryViewDelegate

- (void)retry;

@end

@interface TapToRetryView : UIView

@property (nonatomic, assign) id<TapToRetryViewDelegate> delegate;

@end
