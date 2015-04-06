//
//  StuzzicoClass.m
//  iBeerstro
//
//  Created by Stefano Radice on 28/02/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import "StuzzicoClass.h"

@implementation StuzzicoClass

@synthesize identification, nome,descrizione, immagine;

- (void)logStuzzico
{
    NSLog(@"\nIdentification: %@\nNome: %@\nDescrizione: %@\nImmagine: %@", identification, nome, descrizione, immagine);
}

@end
