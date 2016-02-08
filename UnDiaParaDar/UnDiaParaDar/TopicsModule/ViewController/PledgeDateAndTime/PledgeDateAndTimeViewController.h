//
//  PledgeDateAndTimeViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tailor.h"

@class PositiveAction, TopicService;
@protocol Routing;

@interface PledgeDateAndTimeViewController : UIViewController <LeftCancelButtonProtocol, RightConfirmButtonProtocol>

- (instancetype)initWithRouting:(id<Routing>)routing
             withPositiveAction:(PositiveAction*)positiveAction
               withTopicService:(TopicService*)topicService;
@end
