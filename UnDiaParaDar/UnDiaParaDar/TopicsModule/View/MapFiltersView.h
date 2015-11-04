//
//  MapFiltersView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/1/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapFiltersViewDelegate <NSObject>

- (void)didTapCancel;
- (void)didTapAccept;

@end

@interface MapFiltersView : UIView

@property (nonatomic, assign) id<MapFiltersViewDelegate> delegate;
@property (nonatomic, readonly) NSUInteger radio;
@property (nonatomic, readonly) BOOL radioEnabled;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

- (void)modalStyle;

@end
