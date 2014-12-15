//
//  LeaveComment.h
//  iBeerstro
//
//  Created by Stefano Radice on 06/09/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveComment : NSObject
{
    NSMutableData *responseData;
}

+ (LeaveComment *)sharedClass;
- (void)leaveComment:(NSString*)comment from:(NSString*)username about:(NSString*)product;
- (void)voteWith:(float)rating from:(NSString*)username about:(NSString*)product;

@end
