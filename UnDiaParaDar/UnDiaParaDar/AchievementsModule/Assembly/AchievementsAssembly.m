//
//  AchievementsAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsAssembly.h"
#import "ServiceModuleAssembly.h"

@interface AchievementsAssembly ()

@property (nonatomic, strong) ServiceModuleAssembly *serviceAssembly;

@end

@implementation AchievementsAssembly

- (AchievementsViewController *)achievementsViewController
{
    SEL selector = @selector(initWithAchievementService:);
    return [TyphoonDefinition withClass:[AchievementsViewController class]
                          configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.serviceAssembly achievementService]];
        }];
    }];
}

@end
