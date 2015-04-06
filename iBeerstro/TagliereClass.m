//
//  TagliereClass.m
//  iBeerstro
//
//  Created by Stefano Radice on 28/02/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import "TagliereClass.h"

@implementation TagliereClass

@synthesize identification, nome,descrizione, immagine;

- (void)logTagliere
{
    NSLog(@"\nIdentification: %@\nNome: %@\nDescrizione: %@\nImmagine: %@", identification, nome, descrizione, immagine);
}

@end
