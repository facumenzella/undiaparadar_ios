//
//  TopicsCollectionViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;
@class TopicService;

@interface TopicsCollectionViewController : UICollectionViewController

- (instancetype)initWithRouting:(id<Routing>)routing withTopicsService:(TopicService*)topicService;

@end
