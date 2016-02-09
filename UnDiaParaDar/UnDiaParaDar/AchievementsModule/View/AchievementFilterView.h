//
//  AchievementFilter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementFilterView : UIView

- (void)populateWithQuantity:(NSUInteger)quantity withCategory:(NSString*)category;

- (void)setActive:(BOOL)active;

@end
