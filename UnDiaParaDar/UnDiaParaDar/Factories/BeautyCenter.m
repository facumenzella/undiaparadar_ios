//
//  BeautyCenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/4/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "BeautyCenter.h"

static NSString * const HELVETICA_NEUE_THIN = @"HelveticaNeue-Thin";
static NSString * const HELVETICA_NEUE_LIGHT = @"HelveticaNeue-Light";
static NSString * const HELVETICA_NEUE_MEDIUM = @"HelveticaNeue-Medium";
static NSString * const HELVETICA_NEUE_BOLD = @"HelveticaNeue-Bold";

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
static UIColor *color4;
static UIColor *color5;

@implementation BeautyCenter

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
        default:
            break;
    }
}

- (void)buildFonts
{
    font1a = [UIFont fontWithName:HELVETICA_NEUE_LIGHT size:18];
    font1b = [UIFont fontWithName:HELVETICA_NEUE_LIGHT size:20];
    font1c = [UIFont fontWithName:HELVETICA_NEUE_LIGHT size:22];
    font1d = [UIFont fontWithName:HELVETICA_NEUE_LIGHT size:24];
    font1e = [UIFont fontWithName:HELVETICA_NEUE_LIGHT size:30];
    
    font2a = [UIFont fontWithName:HELVETICA_NEUE_THIN size:18];
    font2b = [UIFont fontWithName:HELVETICA_NEUE_THIN size:20];
    font2c = [UIFont fontWithName:HELVETICA_NEUE_THIN size:22];
    font2d = [UIFont fontWithName:HELVETICA_NEUE_THIN size:24];
    font2e = [UIFont fontWithName:HELVETICA_NEUE_THIN size:30];
    
    font3a = [UIFont fontWithName:HELVETICA_NEUE_MEDIUM size:18];
    font3b = [UIFont fontWithName:HELVETICA_NEUE_MEDIUM size:20];
    font3c = [UIFont fontWithName:HELVETICA_NEUE_MEDIUM size:22];
    font3d = [UIFont fontWithName:HELVETICA_NEUE_MEDIUM size:24];
    font3e = [UIFont fontWithName:HELVETICA_NEUE_MEDIUM size:30];
    
    font4a = [UIFont fontWithName:HELVETICA_NEUE_BOLD size:18];
    font4b = [UIFont fontWithName:HELVETICA_NEUE_BOLD size:20];
    font4c = [UIFont fontWithName:HELVETICA_NEUE_BOLD size:22];
    font4d = [UIFont fontWithName:HELVETICA_NEUE_BOLD size:24];
    font4e = [UIFont fontWithName:HELVETICA_NEUE_BOLD size:30];
}

@end
