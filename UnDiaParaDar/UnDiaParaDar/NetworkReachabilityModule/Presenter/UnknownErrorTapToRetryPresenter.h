//
//  UnknownErrorTapToRetry.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/15/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TapToRetryView.h"

@interface UnknownErrorTapToRetryPresenter : NSObject <TapToRetryViewPresenter>

@property (nonatomic, strong, readonly) NSString *tapTitle;

@end
