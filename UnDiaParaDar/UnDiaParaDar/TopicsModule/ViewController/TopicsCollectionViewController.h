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

typedef void (^SelectedTopicsCallback)(BOOL enabled);

@protocol TopicsSelectionDelegate <NSObject>

- (void)viewController:(UIViewController*)viewController
       didSelectTopics:(NSArray*)topics
          withCallback:(SelectedTopicsCallback)callback;

@end

@interface TopicsCollectionViewController : UICollectionViewController

@property (nonatomic, assign) id<TopicsSelectionDelegate> selectionDelegate; 

- (instancetype)initWithRouting:(id<Routing>)routing
              withTopicsService:(TopicService*)topicService
    withTopicsSelectionDelegate:(id<TopicsSelectionDelegate>)selectionDelegate;

@end
