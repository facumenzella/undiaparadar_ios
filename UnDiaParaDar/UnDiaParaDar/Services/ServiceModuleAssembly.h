//
//  ServiceModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"

@class TopicService, UserService, AchievementService, RestkitService, MappingProvider;

@interface ServiceModuleAssembly : TyphoonAssembly

- (TopicService*)topicService;
- (UserService*)userService;
- (AchievementService*)achievementService;
- (RestkitService*)restkitService;
- (MappingProvider*)mappingProvider;

@end
