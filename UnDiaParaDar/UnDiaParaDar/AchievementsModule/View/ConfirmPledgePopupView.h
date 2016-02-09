//
//  ConfirmPositiveActionPopupView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PopupView.h"

@protocol ConfirmPledgePopupViewDelegate <NSObject>

- (void)dismiss;
- (void)confirmWithCode:(NSString*)code;

@end

@interface ConfirmPledgePopupView : PopupView

@property (nonatomic, weak) id<ConfirmPledgePopupViewDelegate> delegate;

- (void)modalStyle;

@end
