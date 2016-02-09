//
//  AchievementsAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/8/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "AchievementsAssembly.h"
#import "ServiceModuleAssembly.h"
#import "RoutingModuleAssembly.h"

@interface AchievementsAssembly ()

@property (nonatomic, strong) ServiceModuleAssembly *serviceAssembly;
@property (nonatomic, strong) RoutingModuleAssembly *routingAssembly;


@end

@implementation AchievementsAssembly

- (AchievementsViewController *)achievementsViewController
{
    SEL selector = @selector(initWithAchievementService:withRouting:);
    return [TyphoonDefinition withClass:[AchievementsViewController class]
                          configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.serviceAssembly achievementService]];
            [initializer injectParameterWith:[self.routingAssembly routing]];
        }];
    }];
}

- (ConfirmPledgeViewController*)confirmPledgeViewController
{
    SEL selector = @selector(initWithAchievementService:withRouting:);
    return [TyphoonDefinition withClass:[ConfirmPledgeViewController class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self.serviceAssembly achievementService]];
                                  [initializer injectParameterWith:[self.routingAssembly routing]];
                              }];
                          }];
}

@end
