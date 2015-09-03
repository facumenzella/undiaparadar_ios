//
//  ButtonFactory.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "ButtonFactory.h"

@implementation ButtonFactory

+ (UIButton*)menuButton
{
    static NSString *sandwichButton = @"nav_bar_icon_menu.png";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 13.5)];
    [button setBackgroundImage:[UIImage imageNamed:sandwichButton] forState:UIControlStateNormal];
    return button;
}

@end
