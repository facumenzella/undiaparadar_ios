//
//  UserService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/11/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserService : NSObject

- (User*)cachedUser;
- (void)userWithCallback:(void (^)(User*))callback;

@end
