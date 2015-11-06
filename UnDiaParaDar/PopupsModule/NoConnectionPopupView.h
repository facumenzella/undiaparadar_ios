//
//  NoConnectionPopupView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PopupView.h"

@protocol NoConnectionPopupViewDelegate <NSObject>

- (void)understood;

@end

@interface NoConnectionPopupView : PopupView

@property (nonatomic, assign) id<NoConnectionPopupViewDelegate> delegate;

@end
