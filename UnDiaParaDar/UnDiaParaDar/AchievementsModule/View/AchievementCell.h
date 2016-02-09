//
//  AchievementCell.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "AchievementBaseCellProtocol.h"

@protocol AchievementCellDelegate <NSObject>

- (void)pledgeWithItem:(id<AchievementBaseCellProtocol>)item;

@end

@interface AchievementCell : RETableViewCell

@end
