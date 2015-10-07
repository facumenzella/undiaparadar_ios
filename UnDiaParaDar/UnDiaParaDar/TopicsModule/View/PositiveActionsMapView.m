//
//  PositiveActionsMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapView.h"
#import "ButtonFactory.h"
#import "PositiveActionAnnotation.h"
#import "BeautyCenter.h"

#import <MapKit/MapKit.h>
#import <PureLayout/PureLayout.h>

@interface PositiveActionsMapView () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *overTitleView;
@property (nonatomic, strong) UITextView *overTitleTextView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *pledgeButton;

@property (nonatomic) BOOL didTapOnce;
@property (nonatomic, strong) NSArray *defaultConstraints;
@property (nonatomic) CGFloat mapHeightActive;
@property (nonatomic, strong) NSArray *activeConstraints;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITextView *positiveActionTitle;
@property (nonatomic, strong) UIImageView *colorBandImageView;

@end

@implementation PositiveActionsMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        [self setupHeight];
        [self buildSubviews];
        [self styleSubviews];
        [self activate:NO];
    }
    return self;
}

- (void)addPositiveActions:(NSArray*)positiveActions
{
    [self.mapView addAnnotations:positiveActions];
}

- (void)showActivePositiveActionWithTitle:(NSString*)title withSubtitle:(NSString*)subttitle
{
    self.overTitleTextView.text = title;
    self.positiveActionTitle.text = subttitle;
}

- (void)setupHeight
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    self.mapHeightActive = (screenHeight / 8);
}

- (void)buildSubviews
{
    [self buildMapView];
    [self buildFooterView];
    [self buildOverTittle];
    [self buildButtons];
}

- (void)buildMapView
{
    self.mapView = [[MKMapView alloc] initForAutoLayout];
    self.mapView.delegate = self;
    [self addSubview: self.mapView];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = NO;
}

- (void)buildOverTittle
{
    self.overTitleView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.overTitleView];
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.overTitleView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    self.overTitleView.layer.cornerRadius = 10;
    self.overTitleView.clipsToBounds = YES;
    [self.overTitleView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mapView withOffset:16];
    
    self.overTitleTextView = [[UITextView alloc] initForAutoLayout];
    self.overTitleTextView.scrollEnabled = NO;
    self.overTitleTextView.editable = NO;
    [self.overTitleView addSubview: self.overTitleTextView];
    [self.overTitleTextView autoPinEdgesToSuperviewEdges];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectDetail)];
    [self.overTitleView addGestureRecognizer:tap];
}

- (void)buildButtons
{
    self.shareButton = [ButtonFactory buttonWithImage:@"share"];
    self.pledgeButton = [ButtonFactory buttonWithImage:@"pledge"];
    
    [self addSubview:self.shareButton];
    [self addSubview:self.pledgeButton];
    [self.shareButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:32];
    [self.pledgeButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:-32];
    
    [self.shareButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-16];
    [self.pledgeButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.overTitleView withOffset:-16];
}

- (void)buildFooterView
{
    self.footerView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.footerView];
    
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.footerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapView];
    
    self.defaultConstraints = [NSLayoutConstraint autoCreateAndInstallConstraints:^{
        [self.footerView autoSetDimension:ALDimensionHeight toSize:0];
    }];
    
    self.activeConstraints = [NSLayoutConstraint autoCreateConstraintsWithoutInstalling:^{
        [self.footerView autoSetDimension:ALDimensionHeight toSize:self.mapHeightActive];
    }];
    
    
    [self buildPositiveActionTitle];
    [self buildTitleUnderline];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectDetail)];
    [self.footerView addGestureRecognizer:tap];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UITextView alloc] initForAutoLayout];
    self.positiveActionTitle.scrollEnabled = NO;
    self.positiveActionTitle.editable = NO;
    [self.footerView addSubview: self.positiveActionTitle];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
}

- (void)buildTitleUnderline
{
    self.colorBandImageView = [[UIImageView alloc] initForAutoLayout];
    UIImage *colorBand = [UIImage imageNamed:@"color_band"];
    [self.colorBandImageView setImage: colorBand];
    
    [self.footerView addSubview: self.colorBandImageView];
    [self.colorBandImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView: self.positiveActionTitle withOffset:8];
    [self.colorBandImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.colorBandImageView autoMatchDimension:ALDimensionWidth
                                    toDimension:ALDimensionWidth
                                         ofView:self.positiveActionTitle];
}

#pragma mark - Style

- (void)styleSubviews
{
    [self.overTitleView setBackgroundColor: [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed]];
    
    [self.overTitleTextView setTextColor: [UIColor whiteColor]];
    [self.overTitleTextView setBackgroundColor:[UIColor clearColor]];
    [self.overTitleTextView setFont: [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                    withSize:BeautyCenterTypographySizeB]];
    [self.overTitleTextView setTextAlignment: NSTextAlignmentCenter];
    
    [self.footerView setBackgroundColor: [UIColor whiteColor]];
    
    [self.positiveActionTitle setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionTitle setTextColor: [UIColor colorWithRed:211/255.0 green:0 blue:11/255.0 alpha:1]];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[PositiveActionAnnotation class]]) {
        self.activeAnnotation = (PositiveActionAnnotation*)view.annotation;
        
        
        NSString *title = self.activeAnnotation.title;
        NSString *subtitle = self.activeAnnotation.pSubtitle;
        [self showActivePositiveActionWithTitle:title withSubtitle:subtitle];
        
        self.footerView.userInteractionEnabled = YES;
        self.overTitleView.userInteractionEnabled = self.footerView.userInteractionEnabled;
        
        if (!self.didTapOnce) {
            self.didTapOnce = !self.didTapOnce;
            [self activate:YES];
        }
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // Handle any custom annotations.
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"mapPin"];
    if(aView){
        aView.annotation = annotation;
    } else {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapPin"];
    }
    
    if ([annotation isKindOfClass:[PositiveActionAnnotation class]]) {
        aView.image = ((PositiveActionAnnotation*)annotation).locationPinImage;
        aView.canShowCallout = YES;
    }
    
    return aView;
}

- (void)activate:(BOOL)active
{
    if (active) {
        [UIView animateWithDuration:.4 animations:^{
            [self activateViews:active];
            
            [self.defaultConstraints autoRemoveConstraints];
            [self.activeConstraints autoInstallConstraints];
            [self layoutIfNeeded];
        }];
    } else {
        [self activateViews:active];
    }
}

- (void)activateViews:(BOOL)active
{
    self.shareButton.hidden = !active;
    self.pledgeButton.hidden = !active;
    self.overTitleView.hidden = !active;
}

- (void)zoomToMyLocation
{
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - Tap

- (void)didSelectDetail
{
    [self.pAMVDelegate didSelectDetail];
}

@end
