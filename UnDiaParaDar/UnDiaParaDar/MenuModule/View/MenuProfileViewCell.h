//
//  MenuProfileViewCell.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 7/21/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "RETableViewCell.h"

@class MenuProfilePresenter;

@interface MenuProfileViewCell : RETableViewCell

@property (nonatomic, strong) MenuProfilePresenter *presenter;

@end
