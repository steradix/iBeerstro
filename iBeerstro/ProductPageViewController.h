//
//  ProductPageViewController.h
//  iBeerstro
//
//  Created by Stefano Radice on 23/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductPageViewController : UIPageViewController

@property (strong, nonatomic) NSDictionary * dataList;
@property (strong, nonatomic) NSString * nameOfProduct;
@property (strong, nonatomic) NSArray * listOfProducts;

@end
