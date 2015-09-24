//
//  TermsAndConditionsAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TermsAndConditionsAssembly.h"
#import "RoutingModuleAssembly.h"
#import "ServiceModuleAssembly.h"

#import "TermsAndConditionsViewController.h"
#import "TyphoonConfigPostProcessor.h"

@interface TermsAndConditionsAssembly ()

@end

@implementation TermsAndConditionsAssembly

- (TermsAndConditionsViewController*)termsAndConditionsViewController
{
    NSString *path = TyphoonConfig(@"termsAndConditions");
    SEL selector = @selector(initWithTYCPath:);
    return [TyphoonDefinition withClass:[TermsAndConditionsViewController class] configuration:^(TyphoonDefinition* definition) {
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith: path];
        }];
    }];
}

@end
