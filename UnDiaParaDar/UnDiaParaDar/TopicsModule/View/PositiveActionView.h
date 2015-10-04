//
//  PositiveActionView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PositiveAction;

@interface PositiveActionView : UIView

- (void)populateWithPositiveAction:(PositiveAction*)positiveAction withTopicImage:(NSString*)topicImage;


@end
