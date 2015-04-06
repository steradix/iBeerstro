//
//  SecondoClass.m
//  iBeerstro
//
//  Created by Stefano Radice on 28/02/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import "SecondoClass.h"

@implementation SecondoClass

@synthesize identification, nome,descrizione, immagine;

- (void)logSecondo
{
    NSLog(@"\nIdentification: %@\nNome: %@\nDescrizione: %@\nImmagine: %@", identification, nome, descrizione, immagine);
}

@end
