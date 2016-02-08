//
//  AchievementsAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsAssembly.h"

@implementation AchievementsAssembly

- (AchievementsViewController *)achievementsViewController
{
    SEL selector = @selector(init);
    return [TyphoonDefinition withClass:[AchievementsViewController class]
                          configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
        }];
    }];
}

@end
