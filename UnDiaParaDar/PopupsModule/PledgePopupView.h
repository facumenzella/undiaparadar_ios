//
//  PledgePopupView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PopupView.h"

@protocol PledgeViewDelegate <NSObject>

- (void)keepLooking;
- (void)pledge;

@end

@interface PledgePopupView : PopupView

@property (nonatomic, weak) id<PledgeViewDelegate> delegate;

- (void)modalStyle;

@end
