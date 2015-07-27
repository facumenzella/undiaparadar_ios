//
//  SWRevealArchitect.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/27/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "Architect.h"

@interface SWRevealArchitect : NSObject<Architect>

- (UIViewController*)buildMainScreenForFlow:(id<Director>)flow withRootViewController:(UIViewController*)vc;

@end
