//
//  RoutingModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/20/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "RoutingModuleAssembly.h"
#import "MenuModuleAssembly.h"
#import "SplashModuleAssembly.h"
#import "SWRevealDirector.h"
#import "SWRevealArchitect.h"
#import "SWRevealTailor.h"
#import "UDPDRouting.h"

// Ignore no selector in translation unit
#pragma clang diagnostic ignored "-Wselector"
#pragma GCC diagnostic ignored "-Wundeclared-selector"

@interface RoutingModuleAssembly ()

@property (nonatomic, strong) LoginModuleAssembly *loginModuleAssembly;
@property (nonatomic, strong) MenuModuleAssembly *menuModuleAssembly;
@property (nonatomic, strong) ProfileModuleAssembly *profileModuleAssembly;
@property (nonatomic, strong) SplashModuleAssembly *splashModuleAssembly;

@end

@implementation RoutingModuleAssembly

- (id<Routing>) routing
{
    SEL selector = @selector(initWithDirector:withLoginModuleAssembly:withProfileModuleAssembly:withSplashModuleAssembly:withArchitect:);
    return [TyphoonDefinition withClass:[UDPDRouting class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[self iphoneDirector]];
                                  [initializer injectParameterWith:self.loginModuleAssembly];
                                  [initializer injectParameterWith:self.profileModuleAssembly];
                                  [initializer injectParameterWith:self.splashModuleAssembly];
                                  [initializer injectParameterWith:[self iphoneArchitect]];
                              }];
                          }];
}

- (id<Tailor>) iphoneTailor
{
    SEL selector = @selector(init);
    return [TyphoonDefinition withClass:[SWRevealTailor class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                              }];
                          }];
    
}

- (id<Architect>) iphoneArchitect
{
    SEL selector = @selector(initWithMenuModuleAssembly:withTailor:);
    return [TyphoonDefinition withClass:[SWRevealArchitect class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:self.menuModuleAssembly];
                                  [initializer injectParameterWith:[self iphoneTailor]];
                              }];
                          }];

}

- (id<Director>) iphoneDirector
{
    SEL selector = @selector(initWithWindow:);
    return [TyphoonDefinition withClass:[SWRevealDirector class]
                          configuration:^(TyphoonDefinition* definition) {
                              [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
                                  [initializer injectParameterWith:[UIApplication sharedApplication].keyWindow];
                              }];
                          }];
}

@end
