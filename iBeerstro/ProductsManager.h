//
//  ProductsManager.h
//  iBeerstro
//
//  Created by Stefano Radice on 21/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductsManager : NSObject

+ (ProductsManager *)sharedClass;

- (NSArray*)listaTaglieri;
- (NSDictionary*)taglieri;
- (NSDictionary*)tagliereConNome:(NSString*)nomeTagliere;

- (NSArray*)listaHamburger;
- (NSDictionary*)hamburger;
- (NSDictionary*)hamburgerConNome:(NSString*)nomeHamburger;

- (NSArray*)listaSecondi;
- (NSDictionary*)secondi;
- (NSDictionary*)secondoConNome:(NSString*)nomeSecondo;

- (NSArray*)listaDessert;
- (NSDictionary*)dessert;
- (NSDictionary*)dessertConNome:(NSString*)nomeDessert;

- (NSArray*)listaPanini;
- (NSDictionary*)panini;
- (NSDictionary*)paninoConNome:(NSString*)nomePanino;

- (NSArray*)listaStuzzichi;
- (NSDictionary*)stuzzichi;
- (NSDictionary*)stuzzicoConNome:(NSString*)nomeStuzzico;

- (NSArray*)listaRustici;
- (NSDictionary*)rustici;
- (NSDictionary*)rusticoConNome:(NSString*)nomeRustico;

- (NSArray*)listaPiadine;
- (NSDictionary*)piadine;
- (NSDictionary*)piadinaConNome:(NSString*)nomePiadina;

@end
