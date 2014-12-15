//
//  SessionChecker.m
//  iBeerstro
//
//  Created by Stefano Radice on 26/07/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "SessionChecker.h"

@implementation SessionChecker

static SessionChecker *sharedClassInstance = nil;

+ (SessionChecker *) sharedClass {
	@synchronized(self) {
		if (!sharedClassInstance)
			sharedClassInstance = [[SessionChecker alloc] init];
        return sharedClassInstance;
	}
}

- (void)checkSessionWithLogs
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/check_session.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (void)fetchedData:(NSData *)responseData
{
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData
                     options:kNilOptions error:nil];
    
    NSLog(@"JSON: %@", json);
}

@end
