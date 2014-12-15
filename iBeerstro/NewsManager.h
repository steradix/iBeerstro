//
//  NewsManager.h
//  iBeerstro
//
//  Created by Tapook Vincenzo on 23/05/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsManagerDelegate <NSObject>

- (void)dataLoaded:(NSArray*)data;

@end

@interface NewsManager : NSObject

@property (assign, nonatomic) id <NewsManagerDelegate> delegate;

+ (NewsManager *)sharedClass;
- (void)getNewsFromServer;

@end
