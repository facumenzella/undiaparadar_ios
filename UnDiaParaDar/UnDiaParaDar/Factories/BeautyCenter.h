//
//  BeautyCenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BeautyCenterTypographyStyle) {
    BeautyCenterTypographyStyleThin,
    BeautyCenterTypographyStyleLight,
    BeautyCenterTypographyStyleMedium,
    BeautyCenterTypographyStyleBold
};

typedef NS_ENUM(NSUInteger, BeautyCenterTypographySize) {
    BeautyCenterTypographySizeA,
    BeautyCenterTypographySizeB,
    BeautyCenterTypographySizeC,
    BeautyCenterTypographySizeD
};

@interface BeautyCenter : NSObject

+ (UIFont*)beautyCenterFontWithStyle:(BeautyCenterTypographyStyle)style withSize:(BeautyCenterTypographySize)size;

@end
