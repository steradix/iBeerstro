//
//  DettaglioBirreViewController.h
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeersPageViewController : UIPageViewController

@property (strong, nonatomic) NSArray * beersList;
@property (strong, nonatomic) Birra * startingBeer;

@end
