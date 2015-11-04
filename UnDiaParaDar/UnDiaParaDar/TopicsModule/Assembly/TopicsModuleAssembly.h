//
//  TopicsModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"

@class TopicsCollectionViewController, PositiveActionsFilteredWithMapViewController, PositiveActionViewController;
@class PositiveAction, MapFiltersViewController;

@interface TopicsModuleAssembly : TyphoonAssembly

- (TopicsCollectionViewController*)topicsCollectionViewController;
- (PositiveActionsFilteredWithMapViewController*)positiveActionsMapViewControllerWithTopics:(NSArray*)topics;
- (PositiveActionViewController*)positiveActionViewControllerWithPositiveAction:(PositiveAction*)positiveAction;
- (MapFiltersViewController*)mapFiltersViewController;

@end
