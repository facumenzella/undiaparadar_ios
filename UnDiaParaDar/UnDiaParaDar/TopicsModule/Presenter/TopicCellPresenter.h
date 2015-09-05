//
//  TopicPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Topic;

@interface TopicCellPresenter : NSObject

@property (nonatomic) BOOL selected;

- (NSString*)name;
- (NSString*)image;
- (NSString*)selectedImage;

- (instancetype)initWithTopic:(Topic*)topic;

@end
