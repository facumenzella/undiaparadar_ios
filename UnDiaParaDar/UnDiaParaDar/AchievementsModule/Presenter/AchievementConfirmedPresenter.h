//
//  AchievementConfirmedPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "AchievementBaseCellProtocol.h"

@interface AchievementConfirmedPresenter : RETableViewItem <AchievementBaseCellProtocol>

@property (nonatomic) BOOL confirmEnabled;
@property (nonatomic, strong, readonly) NSString *state;

@end
