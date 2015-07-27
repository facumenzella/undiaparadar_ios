//
//  Architect.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Tailor;

@protocol Architect <NSObject>

- (UIViewController*)buildMainScreenWithRootViewController:(UIViewController*)vc;

@end
