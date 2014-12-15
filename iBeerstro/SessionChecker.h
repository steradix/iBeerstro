//
//  SessionChecker.h
//  iBeerstro
//
//  Created by Stefano Radice on 26/07/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionChecker : NSObject

+ (SessionChecker *)sharedClass;
- (void)checkSessionWithLogs;

@end
