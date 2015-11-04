//
//  PositiveActionsFilteredWithMapViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/13/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tailor.h"

@protocol Routing;
@class TopicService;

@interface PositiveActionsFilteredWithMapViewController : UIViewController<RightFilterButtonProtocol>

- (instancetype)initWithRouting:(id<Routing>)routing
               withTopicService:(TopicService*)topicService
                     withTopics:(NSArray*)topics;
@end
