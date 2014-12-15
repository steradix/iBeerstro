//
//  ConnectionChecker.m
//  UCBItalia
//
//  Created by Tapook Vincenzo on 16/05/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "ConnectionChecker.h"
#import "Reachability.h"

@implementation ConnectionChecker

static ConnectionChecker *sharedClassInstance = nil;

+ (ConnectionChecker *) sharedClass
{
	@synchronized(self)
    {
		if (!sharedClassInstance)
			sharedClassInstance = [[ConnectionChecker alloc] init];
        return sharedClassInstance;
	}
}

- (BOOL)checkInternetConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if(networkStatus == NotReachable)
    {
        return NO;
    }
    return YES;
}

@end
