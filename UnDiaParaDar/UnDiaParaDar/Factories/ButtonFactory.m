//
//  ButtonFactory.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ButtonFactory.h"
#import "UIImage+Color.h"

@implementation ButtonFactory

+ (UIButton*)menuButton
{
    static NSString *sandwichButton = @"nav_bar_icon_menu.png";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 13.5)];
    [button setBackgroundImage:[UIImage imageNamed:sandwichButton] forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)nextButton
{
    static NSString *nextOnButton = @"next_heart_on.png";
    static NSString *nextButton = @"next_heart.png";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 25.5)];
    [button setBackgroundImage:[UIImage imageNamed:nextButton] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageNamed:nextOnButton] forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*)buttonWithImage:(NSString*)img
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    return button;
}

@end
