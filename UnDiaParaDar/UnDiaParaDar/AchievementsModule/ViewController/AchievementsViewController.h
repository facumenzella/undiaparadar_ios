//
//  AchievementsViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AchievementService;

@interface AchievementsViewController : UIViewController

- (instancetype)initWithAchievementService:(AchievementService*)service;

@end
