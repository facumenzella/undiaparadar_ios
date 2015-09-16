//
//  TopicsModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"

@class TopicsCollectionViewController, PositiveActionsWithMapViewController;

@interface TopicsModuleAssembly : TyphoonAssembly

- (TopicsCollectionViewController*)topicsCollectionViewController;
- (PositiveActionsWithMapViewController*)positiveActionsWithMapViewController;

@end
