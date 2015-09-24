//
//  QueEsPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueEsPresenter : NSObject

@property (nonatomic, strong) NSString *htmlTermsAndConditions;

- (instancetype)initWithPathToHTML:(NSString*)pathToHTML;

@end
