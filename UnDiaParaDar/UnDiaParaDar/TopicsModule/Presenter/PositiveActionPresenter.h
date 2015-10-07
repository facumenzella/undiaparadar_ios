//
//  PositiveActionPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PositiveActionPresenter <NSObject>

- (NSString*)paTitle;
- (NSString*)paSubtitle;
- (NSString*)paDescription;
- (NSString*)paCity;
- (NSString*)paCountry;
- (NSString*)paExternalURL;

@end
