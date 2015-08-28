//
//  MenuOptionPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "RETableViewItem.h"

@interface MenuOptionPresenter : RETableViewItem

- (instancetype)initWithOptionImage:(NSString*)image withOptionTitle:(NSString*)title;

@property (nonatomic, strong) UIImage *optionImage;
@property (nonatomic, strong) NSString *option;

@end
