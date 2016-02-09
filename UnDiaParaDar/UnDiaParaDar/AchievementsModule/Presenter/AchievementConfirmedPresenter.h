//
//  AchievementConfirmedPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "AchievementBaseCellProtocol.h"
#import "AchievementCell.h"

@interface AchievementConfirmedPresenter : RETableViewItem <AchievementBaseCellProtocol>

@property (nonatomic, readonly) BOOL confirmEnabled;
@property (nonatomic, strong, readonly) NSString *state;
@property (nonatomic, strong) NSNumber *positiveActionId;
@property (nonatomic, weak) id<AchievementCellDelegate> delegate;

@end
