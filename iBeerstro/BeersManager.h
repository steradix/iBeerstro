//
//  BeersManager.h
//  iBeerstro
//
//  Created by Stefano Radice on 19/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BeersManagerDelegate <NSObject>

- (void)dataLoaded:(NSArray*)data;

@end

@interface BeersManager : NSObject

@property (assign, nonatomic) id <BeersManagerDelegate> delegate;

+ (BeersManager *)sharedClass;
- (void)getBeersFromServer;

@end
