//
//  BeersManager.m
//  iBeerstro
//
//  Created by Stefano Radice on 19/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "BeersManager.h"

@implementation BeersManager
{
//    NSArray *beers;
}

static BeersManager *sharedClassInstance = nil;

+ (BeersManager *) sharedClass
{
	@synchronized(self)
    {
		if (!sharedClassInstance)
			sharedClassInstance = [[BeersManager alloc] init];
        return sharedClassInstance;
	}
}

- (void)getBeersFromServer
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/birra.php"]];
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
    NSMutableArray *birreTMP = [[NSMutableArray alloc] initWithCapacity:[json count]];
    for (NSDictionary *dict in json)
    {
        Birra *b = [[Birra alloc] init];
        
        b.identification    = [dict objectForKey:@"id"];
        b.nome              = [dict objectForKey:@"nome"];
        b.bicchiere         = [dict objectForKey:@"bicchiere"];
        b.temperatura       = [dict objectForKey:@"temperatura"];
        b.stile             = [dict objectForKey:@"stile"];
        b.gradazione        = [dict objectForKey:@"gradazione"];
        b.birrificio        = [dict objectForKey:@"birrificio"];
        b.medaglione        = [dict objectForKey:@"medaglione"];
        b.provenienza       = [dict objectForKey:@"provenienza"];
        b.disponibilita     = [dict objectForKey:@"disponibile"];
        
        [birreTMP addObject:b];
    }
    
//    beers = [birreTMP copy];
    
    if([self.delegate respondsToSelector:@selector(dataLoaded:)])
        [self.delegate dataLoaded:birreTMP];
}

@end
