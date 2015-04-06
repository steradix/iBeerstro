//
//  HamburgerClass.m
//  iBeerstro
//
//  Created by Stefano Radice on 28/02/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import "HamburgerClass.h"

@implementation HamburgerClass

@synthesize identification, nome,descrizione, immagine;

- (void)logHamburger
{
    NSLog(@"\nIdentification: %@\nNome: %@\nDescrizione: %@\nImmagine: %@", identification, nome, descrizione, immagine);
}

@end
