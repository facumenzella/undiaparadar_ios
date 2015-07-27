//
//  MenuProfilePresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "RETableViewItem.h"

@interface MenuProfilePresenter : RETableViewItem

- (instancetype)initWithUserImage:(NSString*)userImage withUserName:(NSString*)userName;

@property (nonatomic, strong) UIImage *userImage;
@property (nonatomic, strong) NSString *userName;

@end
