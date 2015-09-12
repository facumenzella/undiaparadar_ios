//
//  MenuProfilePresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuProfilePresenter.h"

@implementation MenuProfilePresenter

- (instancetype)initWithUserImage:(NSString*)userImage withUserName:(NSString*)userName
{
    self = [super init];
    if (self) {
        self.userImage = userImage;
        self.userName = userName;
    }
    return self;
}


@end
