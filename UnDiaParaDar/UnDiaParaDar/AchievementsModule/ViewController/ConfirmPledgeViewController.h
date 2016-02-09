//
//  ConfirmPledgeViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/9/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AchievementService;
@protocol Routing;

@interface ConfirmPledgeViewController : UIViewController

- (instancetype)initWithAchievementService:(AchievementService*)service withRouting:(id<Routing>)routing;

@end
