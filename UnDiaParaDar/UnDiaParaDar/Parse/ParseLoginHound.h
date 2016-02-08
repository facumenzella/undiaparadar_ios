//
//  ParseLoginHound.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginDelegate;

@interface ParseLoginHound : NSObject

@property (nonatomic, weak) id<LoginDelegate> delegate;

- (void)login;

@end
