//
//  Birra.m
//  iBeerstro
//
//  Created by Stefano Radice on 31/10/13.
//  Copyright (c) 2013 Stefano Radice. All rights reserved.
//

#import "Birra.h"

@implementation Birra
@synthesize identification, nome,bicchiere, stile, gradazione, birrificio, provenienza, medaglione, disponibilita;

- (void)logBeer
{
    NSLog(@"\nIdentification: %@\nNome: %@\nBicchiere: %@\nStile: %@\nGradazione: %@\nBirrificio: %@\nProvenienza: %@\nMedaglione: %@\nDisponibilità: %@", identification, nome, bicchiere, stile, gradazione, birrificio, provenienza, medaglione, disponibilita);
}

@end