//
//  AchievementsViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsViewController.h"
#import "AchievementsView.h"

@interface AchievementsViewController ()

@property (nonatomic, strong) AchievementsView *achievementsView;

@end

@implementation AchievementsViewController

- (void)loadView
{
    self.achievementsView = [[AchievementsView alloc] init];
    self.view = self.achievementsView;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"ACHIEVEMENTS_SECTION", @"Logros");
}

@end
