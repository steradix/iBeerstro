//
//  Dessert.h
//  iBeerstro
//
//  Created by Stefano Radice on 13/12/14.
//  Copyright (c) 2014 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DessertClass : NSObject

@property (strong, nonatomic) NSString *identification;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *descrizione;
@property (strong, nonatomic) NSString *immagine;

- (void)logDessert;

@end
