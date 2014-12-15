//
//  NewsManager.m
//  iBeerstro
//
//  Created by Tapook Vincenzo on 23/05/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "NewsManager.h"

#import "News.h"

@implementation NewsManager

static NewsManager *sharedClassInstance = nil;

+ (NewsManager *) sharedClass
{
	@synchronized(self)
    {
		if (!sharedClassInstance)
			sharedClassInstance = [[NewsManager alloc] init];
        return sharedClassInstance;
	}
}

- (void)getNewsFromServer
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/news.php"]];
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
    NSMutableArray *news = [[NSMutableArray alloc] initWithCapacity:[json count]];
    for (NSDictionary *dict in json)
    {
        News *n = [[News alloc] init];
        
        n.identification    = [dict objectForKey:@"id"];
        n.image             = [dict objectForKey:@"immagine"];
        n.title             = [dict objectForKey:@"titolo"];
        n.text              = [dict objectForKey:@"testo"];
        
        [news addObject:n];
    }
    
    if([self.delegate respondsToSelector:@selector(dataLoaded:)])
        [self.delegate dataLoaded:news];
}

@end
