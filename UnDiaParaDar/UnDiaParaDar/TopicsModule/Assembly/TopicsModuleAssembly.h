//
//  TopicsModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"

@class TopicsCollectionViewController, PositiveActionsMapViewController, PositiveActionViewController;
@class PositiveAction;

@interface TopicsModuleAssembly : TyphoonAssembly

- (TopicsCollectionViewController*)topicsCollectionViewController;
- (PositiveActionsMapViewController*)positiveActionsMapViewControllerWithTopics:(NSArray*)topics;
- (PositiveActionViewController*)positiveActionViewControllerWithPositiveAction:(PositiveAction*)positiveAction;

@end
