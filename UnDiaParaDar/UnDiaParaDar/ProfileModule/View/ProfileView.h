//
//  ProfileView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/6/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface ProfileView : UIView

- (void)populateWithUser:(User*)user;

@end
