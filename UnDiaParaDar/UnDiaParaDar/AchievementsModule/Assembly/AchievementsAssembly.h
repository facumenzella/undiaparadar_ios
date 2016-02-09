//
//  AchievementsAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import "AchievementsViewController.h"
#import "ConfirmPledgeViewController.h"

@interface AchievementsAssembly : TyphoonAssembly

- (AchievementsViewController*)achievementsViewController;
- (ConfirmPledgeViewController*)confirmPledgeViewController;

@end
