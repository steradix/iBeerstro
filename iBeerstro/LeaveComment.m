//
//  LeaveComment.m
//  iBeerstro
//
//  Created by Stefano Radice on 06/09/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "LeaveComment.h"

@implementation LeaveComment

static LeaveComment *sharedClassInstance = nil;

+ (LeaveComment *) sharedClass {
	@synchronized(self) {
		if (!sharedClassInstance)
        {
            sharedClassInstance = [[LeaveComment alloc] init];
        }
        return sharedClassInstance;
	}
}

- (void)leaveComment:(NSString*)comment from:(NSString*)username about:(NSString*)product
{
    responseData = [NSMutableData data];
    
    NSString *url = @"http://www.beerstro.it/commenti.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&comment=%@&product=%@", username,comment,product];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)voteWith:(float)rating from:(NSString*)username about:(NSString*)product
{
    responseData = [NSMutableData data];
    
    NSString *url = @"http://www.beerstro.it/marks.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&mark=%@&product=%@", username,[NSString stringWithFormat:@"%f", rating],product];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"ConnectionDidReceiveResponse: %@", response);
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@"ConnectionDidReceiveData");
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection didFailWithError: %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"ConnectionDidFinishLoading");
    
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    responseData = [NSMutableData data];
    
    NSLog(@"RISULTATO: %@", res);
}

@end
