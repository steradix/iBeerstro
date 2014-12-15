//
//  BeerstroHQAnnotation.m
//  iBeerstro
//
//  Created by Stefano Radice on 18/10/13.
//  Copyright (c) 2013 Stefano Radice. All rights reserved.
//

#import "BeerstroHQAnnotation.h"

@implementation BeerstroHQAnnotation

@synthesize coordinate;

-(id) init
{
    coordinate.longitude = 9.0778046;
    coordinate.latitude = 45.5954075;
    return [super init];
}

-(NSString *)title
{
    return @"Beerstrò";
}

-(NSString *)subtitle
{
    return @"via Carlo Romanò, 35 Cesate (MI)";
}

@end
