//
//  RatingView.h
//  iBeerstro
//
//  Created by Stefano Radice on 06/09/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RateView;

@interface RateView : UIView

@property (strong, nonatomic) UIImage *notSelectedImage;
@property (strong, nonatomic) UIImage *halfSelectedImage;
@property (strong, nonatomic) UIImage *fullSelectedImage;
@property (assign, nonatomic) float rating;
@property (assign) BOOL editable;
@property (strong) NSMutableArray * imageViews;
@property (assign, nonatomic) int maxRating;
@property (assign) int midMargin;
@property (assign) int leftMargin;
@property (assign) CGSize minImageSize;

@end