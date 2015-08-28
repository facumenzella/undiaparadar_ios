//
//  MenuOptionPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MenuOptionPresenter.h"

@implementation MenuOptionPresenter

- (instancetype)initWithOptionImage:(NSString*)image withOptionTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        self.optionImage = [UIImage imageNamed:image];
        self.option = title;
    }
    return self;
}


@end
