//
//  DessertsManager.m
//  iBeerstro
//
//  Created by Stefano Radice on 13/12/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "DessertsManager.h"

#import "DessertClass.h"

@implementation DessertsManager

static DessertsManager *sharedClassInstance = nil;

+ (DessertsManager *) sharedClass {
    @synchronized(self) {
        if (!sharedClassInstance)
            sharedClassInstance = [[DessertsManager alloc] init];
        return sharedClassInstance;
    }
}

- (void)getDessertsFromServer
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/dessert.php"]];
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
    NSMutableArray *desserts = [[NSMutableArray alloc] initWithCapacity:[json count]];
    for (NSDictionary *dict in json)
    {
        DessertClass *d = [[DessertClass alloc] init];
        
        d.identification    = [dict objectForKey:@"id"];
        d.nome              = [dict objectForKey:@"nome"];
        d.descrizione       = [dict objectForKey:@"descrizione"];
        d.immagine          = [dict objectForKey:@"immagine"];
        
        [desserts addObject:d];
    }
    
    if([self.delegate respondsToSelector:@selector(dataLoaded:)])
        [self.delegate dataLoaded:desserts];
}

- (NSDictionary*)convertDessertIntoDictionary:(DessertClass*)dessert
{
    NSMutableDictionary *des = [[NSMutableDictionary alloc]init];
    
    [des setObject:dessert.nome forKey:@"nome"];
    [des setObject:dessert.descrizione forKey:@"descrizione"];
    [des setObject:dessert.immagine forKey:@"immagine"];
    
    return des.copy;
}

@end
