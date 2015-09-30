//
//  ServiceModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"

@class TopicService, UserService, RestkitService, MappingProvider;

@interface ServiceModuleAssembly : TyphoonAssembly

- (TopicService*)topicService;
- (UserService*)userService;
- (RestkitService*)restkitService;
- (MappingProvider*)mappingProvider;

@end
