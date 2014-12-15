//
//  News.h
//  iBeerstro
//
//  Created by Tapook Vincenzo on 22/05/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (strong, nonatomic) NSString *identification;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *text;

- (void)logNews;

@end
