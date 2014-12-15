//
//  DessertsManager.h
//  iBeerstro
//
//  Created by Stefano Radice on 13/12/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DessertClass.h"

@protocol DessertsManagerDelegate <NSObject>

- (void)dataLoaded:(NSArray*)data;

@end

@interface DessertsManager : NSObject

@property (assign, nonatomic) id <DessertsManagerDelegate> delegate;

+ (DessertsManager *)sharedClass;
- (void)getDessertsFromServer;
- (NSDictionary*)convertDessertIntoDictionary:(DessertClass*)dessert;

@end
