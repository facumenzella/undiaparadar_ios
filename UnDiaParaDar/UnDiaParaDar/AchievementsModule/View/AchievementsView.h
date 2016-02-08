//
//  AchievementsView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementsView : UIView

@property (nonatomic, strong, readonly) UITableView *tableView;

- (void)setDone:(NSUInteger)done;
- (void)setPledged:(NSUInteger)pledged;
- (void)setNotDone:(NSUInteger)notdone;
- (void)setAll:(NSUInteger)all;

@end
