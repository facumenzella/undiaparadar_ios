//
//  TopicsFilterViewCell.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicCellPresenter;

@interface TopicsFilterViewCell : UICollectionViewCell

- (void)populateCellWithTopic:(TopicCellPresenter *)presenter;

@end
