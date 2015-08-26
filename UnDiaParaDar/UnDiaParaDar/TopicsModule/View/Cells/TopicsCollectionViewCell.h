//
//  TopicCollectionViewCell.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;

@interface TopicsCollectionViewCell : UICollectionViewCell

- (void)populateCellWithTopic: (Topic*)topic;

@end
