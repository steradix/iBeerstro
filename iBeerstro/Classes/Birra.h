//
//  Birra.h
//  iBeerstro
//
//  Created by Stefano Radice on 31/10/13.
//  Copyright (c) 2013 Stefano Radice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Birra : NSObject
@property (strong, nonatomic) NSString *identification;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *bicchiere;
@property (strong, nonatomic) NSString *temperatura;
@property (strong, nonatomic) NSString *stile;
@property (strong, nonatomic) NSString *gradazione;
@property (strong, nonatomic) NSString *birrificio;
@property (strong, nonatomic) NSString *provenienza;
@property (strong, nonatomic) NSString *medaglione;
@property (strong, nonatomic) NSString *disponibilita;

- (void)logBeer;

@end