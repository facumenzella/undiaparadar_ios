//
//  PositiveActionViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;
@class PositiveAction, TopicService;

@interface PositiveActionViewController : UIViewController

- (instancetype)initWithPositiveAction:(PositiveAction*)positiveAction
                           withRouting:(id<Routing>)routing
                      withTopicService:(TopicService*)topicService;
@end
