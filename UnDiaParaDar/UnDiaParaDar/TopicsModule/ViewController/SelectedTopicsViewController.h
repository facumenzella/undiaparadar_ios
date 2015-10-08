//
//  SelectedTopicsViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicService;

@interface SelectedTopicsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

-(instancetype)initWithTopicService:(TopicService*)topicService;

@property (nonatomic, strong) NSMutableArray *selectedTopics;

@end
