//
//  ServiceModuleAssembly.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ServiceModuleAssembly.h"

#import "TopicService.h"

@implementation ServiceModuleAssembly

- (TopicService*)topicService
{
    return [TyphoonDefinition withClass:[TopicService class]];
}


@end
