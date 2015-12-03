//
//  BeautyCenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "BeautyCenter.h"

static NSString * const kHELVETICA_NEUE_THIN = @"HelveticaNeue-Thin";
static NSString * const kHELVETICA_NEUE_LIGHT = @"HelveticaNeue-Light";
static NSString * const kHELVETICA_NEUE_MEDIUM = @"HelveticaNeue-Medium";
static NSString * const kHELVETICA_NEUE_BOLD = @"HelveticaNeue-Bold";

static NSUInteger const kSIZE_A = 14;
static NSUInteger const kSIZE_B = 18;
static NSUInteger const kSIZE_C = 20;
static NSUInteger const kSIZE_D = 22;
static NSUInteger const kSIZE_E = 24;

static UIFont *font1a;
static UIFont *font1b;
static UIFont *font1c;
static UIFont *font1d;
static UIFont *font1e;
static UIFont *font2a;
static UIFont *font2b;
static UIFont *font2c;
static UIFont *font2d;
static UIFont *font2e;
static UIFont *font3a;
static UIFont *font3b;
static UIFont *font3c;
static UIFont *font3d;
static UIFont *font3e;
static UIFont *font4a;
static UIFont *font4b;
static UIFont *font4c;
static UIFont *font4d;
static UIFont *font4e;

static UIColor *color1;
static UIColor *color2;
static UIColor *color3;

@implementation BeautyCenter

+ (void)setup
{
    [BeautyCenter sharedInstance];
}

+ (instancetype)sharedInstance
{
    static BeautyCenter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance buildStyles];
    });
    return sharedInstance;
}

- (void)buildStyles
{
    [self buildFonts];
    [self buildColors];
}

+ (UIColor*)beautyCenterColor:(BeautyCenterColor)color
{
    switch (color) {
        case BeautyCenterColorDarkRed:
            return color1;
            break;
        case BeautyCenterColorGrey:
            return color2;
        case BeautyCenterColorMenuBackgroundGrey:
            return color3;
        default:
            break;
    }
}


+ (UIFont*)beautyCenterFontWithStyle:(BeautyCenterTypographyStyle)style withSize:(BeautyCenterTypographySize)size
{
    UIFont *font = nil;
    switch (style) {
        case BeautyCenterTypographyStyleLight:
            font = [BeautyCenter lightWithSize:size];
            break;
        case BeautyCenterTypographyStyleThin:
            font = [BeautyCenter thinWithSize:size];
            break;
        case BeautyCenterTypographyStyleMedium:
            font = [BeautyCenter mediumWithSize:size];
            break;
        case BeautyCenterTypographyStyleBold:
            font = [BeautyCenter boldWithSize:size];
            break;
        default:
            break;
    }
    return font;
}

+ (UIFont*)lightWithSize:(BeautyCenterTypographySize)size
{
    switch (size) {
        case BeautyCenterTypographySizeA:
            return font1a;
            break;
        case BeautyCenterTypographySizeB:
            return font1b;
            break;
        case BeautyCenterTypographySizeC:
            return font1c;
            break;
        case BeautyCenterTypographySizeD:
            return font1d;
            break;
        case BeautyCenterTypographySizeE:
            return font1e;
            break;
        default:
            break;
    }
}

+ (UIFont*)thinWithSize:(BeautyCenterTypographySize)size
{
    switch (size) {
        case BeautyCenterTypographySizeA:
            return font2a;
            break;
        case BeautyCenterTypographySizeB:
            return font2b;
            break;
        case BeautyCenterTypographySizeC:
            return font2c;
            break;
        case BeautyCenterTypographySizeD:
            return font2d;
            break;
        case BeautyCenterTypographySizeE:
            return font2e;
            break;
        default:
            break;
    }
}

+ (UIFont*)mediumWithSize:(BeautyCenterTypographySize)size
{
    switch (size) {
        case BeautyCenterTypographySizeA:
            return font3a;
            break;
        case BeautyCenterTypographySizeB:
            return font3b;
            break;
        case BeautyCenterTypographySizeC:
            return font3c;
            break;
        case BeautyCenterTypographySizeD:
            return font3d;
            break;
        case BeautyCenterTypographySizeE:
            return font3e;
            break;
        default:
            break;
    }
}

+ (UIFont*)boldWithSize:(BeautyCenterTypographySize)size
{
    switch (size) {
        case BeautyCenterTypographySizeA:
            return font4a;
            break;
        case BeautyCenterTypographySizeB:
            return font4b;
            break;
        case BeautyCenterTypographySizeC:
            return font4c;
            break;
        case BeautyCenterTypographySizeD:
            return font4d;
            break;
        case BeautyCenterTypographySizeE:
            return font4e;
            break;
        default:
            break;
    }
}

- (void)buildFonts
{
    font1a = [UIFont fontWithName:kHELVETICA_NEUE_LIGHT size:kSIZE_A];
    font1b = [UIFont fontWithName:kHELVETICA_NEUE_LIGHT size:kSIZE_B];
    font1c = [UIFont fontWithName:kHELVETICA_NEUE_LIGHT size:kSIZE_C];
    font1d = [UIFont fontWithName:kHELVETICA_NEUE_LIGHT size:kSIZE_D];
    font1e = [UIFont fontWithName:kHELVETICA_NEUE_LIGHT size:kSIZE_E];
    
    font2a = [UIFont fontWithName:kHELVETICA_NEUE_THIN size:kSIZE_A];
    font2b = [UIFont fontWithName:kHELVETICA_NEUE_THIN size:kSIZE_B];
    font2c = [UIFont fontWithName:kHELVETICA_NEUE_THIN size:kSIZE_C];
    font2d = [UIFont fontWithName:kHELVETICA_NEUE_THIN size:kSIZE_D];
    font2e = [UIFont fontWithName:kHELVETICA_NEUE_THIN size:kSIZE_E];
    
    font3a = [UIFont fontWithName:kHELVETICA_NEUE_MEDIUM size:kSIZE_A];
    font3b = [UIFont fontWithName:kHELVETICA_NEUE_MEDIUM size:kSIZE_B];
    font3c = [UIFont fontWithName:kHELVETICA_NEUE_MEDIUM size:kSIZE_C];
    font3d = [UIFont fontWithName:kHELVETICA_NEUE_MEDIUM size:kSIZE_D];
    font3e = [UIFont fontWithName:kHELVETICA_NEUE_MEDIUM size:kSIZE_E];
    
    font4a = [UIFont fontWithName:kHELVETICA_NEUE_BOLD size:kSIZE_A];
    font4b = [UIFont fontWithName:kHELVETICA_NEUE_BOLD size:kSIZE_B];
    font4c = [UIFont fontWithName:kHELVETICA_NEUE_BOLD size:kSIZE_C];
    font4d = [UIFont fontWithName:kHELVETICA_NEUE_BOLD size:kSIZE_D];
    font4e = [UIFont fontWithName:kHELVETICA_NEUE_BOLD size:kSIZE_E];
}

- (void)buildColors
{
    color1 = [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1];
    static const CGFloat factor = 204/255.0;
    color2 = [UIColor colorWithRed:factor green:factor blue:factor alpha:1];
    static const CGFloat menuFactor = 225/255.0;
    color3 = [UIColor colorWithRed:menuFactor green:menuFactor blue:menuFactor alpha:1];
}

@end
