//
//  News.m
//  iBeerstro
//
//  Created by Tapook Vincenzo on 22/05/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize identification, image, title, text;

- (void)logNews
{
    NSLog(@"\nImageUrl: %@\nTitle: %@\nText: %@", image, title, text);
}

@end
