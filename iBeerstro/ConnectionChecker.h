//
//  ConnectionChecker.h
//  UCBItalia
//
//  Created by Tapook Vincenzo on 16/05/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionChecker : NSObject

+ (ConnectionChecker *)sharedClass;

- (BOOL)checkInternetConnection;

@end
