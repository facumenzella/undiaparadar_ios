//
//  MOLazyModalAnimator.h
//  ClaroViajes
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 Monits. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoutingService;

@interface MOLazyModalAnimator : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

-(instancetype)initWithRoutingService:(RoutingService*)routingService;

@end
