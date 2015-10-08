//
//  TopicsSelectedCell.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Topic;

@interface TopicsSelectedCell : UICollectionViewCell

- (void)populateWithTopic:(Topic*)topic;

@end
