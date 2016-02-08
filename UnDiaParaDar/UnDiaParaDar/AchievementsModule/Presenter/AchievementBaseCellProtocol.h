//
//  AchievementBaseCellProtocol.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AchievementBaseCellProtocol <NSObject>

- (BOOL)confirmEnabled;
- (NSString*)title;
- (NSString*)state;

@end
