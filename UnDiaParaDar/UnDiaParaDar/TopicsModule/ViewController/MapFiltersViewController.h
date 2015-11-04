//
//  MapFiltersViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/1/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Routing;
@class TopicService, MapFilters;

@interface MapFiltersViewController : UIViewController

- (instancetype)initWithRouting:(id<Routing>)routing
              withTopicsService:(TopicService*)topicService
                 withMapFilters:(MapFilters*)mapFilters;

@end
