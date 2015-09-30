//
//  Topic.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *selectedImg;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *img40x40On;
@property (nonatomic, strong) NSString *img40x40Off;

@end
