//
//  AchievementsView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AchievementFilters) {
    AchievementFiltersAll,
    AchievementFiltersDone,
    AchievementFiltersPledge,
    AchievementFiltersNotDone
};

@protocol AchievementViewDelegate <NSObject>

- (void)didTapDone;
- (void)didTapPledged;
- (void)didTapNotDone;
- (void)didTapAll;

@end

@interface AchievementsView : UIView

@property (nonatomic, weak) id<AchievementViewDelegate> delegate;
@property (nonatomic, strong, readonly) UITableView *tableView;

- (void)setDone:(NSUInteger)done;
- (void)setPledged:(NSUInteger)pledged;
- (void)setNotDone:(NSUInteger)notdone;
- (void)setAll:(NSUInteger)all;
- (void)setActive:(AchievementFilters)filter;

@end
