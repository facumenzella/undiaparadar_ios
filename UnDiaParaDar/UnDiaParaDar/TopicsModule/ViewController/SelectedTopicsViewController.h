//
//  SelectedTopicsViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicService;

typedef void (^SelectedTopicsChangedCallback)(NSArray *selected);

@interface SelectedTopicsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

-(instancetype)initWithTopicService:(TopicService*)topicService
         withSelectedTopicsCallback:(SelectedTopicsChangedCallback)callback;

@property (nonatomic, strong) NSMutableArray *selectedTopics;

@end
