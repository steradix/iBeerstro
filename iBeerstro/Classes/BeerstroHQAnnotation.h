//
//  BeerstroHQAnnotation.h
//  iBeerstro
//
//  Created by Stefano Radice on 18/10/13.
//  Copyright (c) 2013 Stefano Radice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BeerstroHQAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;

}

@end
