//
//  SecondoClass.h
//  iBeerstro
//
//  Created by Stefano Radice on 28/02/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondoClass : NSObject

@property (strong, nonatomic) NSString *identification;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *descrizione;
@property (strong, nonatomic) NSString *immagine;

- (void)logSecondo;

@end
