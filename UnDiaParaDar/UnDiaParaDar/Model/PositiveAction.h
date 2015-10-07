//
//  PositiveAction.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PositiveActionPresenter.h"

@interface PositiveAction : NSObject <PositiveActionPresenter>

@property (nonatomic) int64_t positiveActionID;

@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, strong) NSString *externalURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *positiveActionDescription;

@property (nonatomic, strong) NSString *ongName;
@property (nonatomic) int64_t ongID;

@property (nonatomic) NSString *topicID;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *city;


@end
