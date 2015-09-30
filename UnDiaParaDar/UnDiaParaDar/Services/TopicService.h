//
//  TopicService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestkitService;

@interface TopicService : NSObject

-(instancetype)initWithRestkitService:(RestkitService*)restkitService;

- (NSMutableArray*)topics;

@end
