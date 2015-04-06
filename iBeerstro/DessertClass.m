//
//  Dessert.m
//  iBeerstro
//
//  Created by Stefano Radice on 13/12/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import "DessertClass.h"

@implementation DessertClass

@synthesize identification, nome,descrizione, immagine;

- (void)logDessert
{
    NSLog(@"\nIdentification: %@\nNome: %@\nDescrizione: %@\nImmagine: %@", identification, nome, descrizione, immagine);
}

@end
