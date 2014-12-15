//
//  ProductsManager.m
//  iBeerstro
//
//  Created by Stefano Radice on 21/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "ProductsManager.h"

@implementation ProductsManager
{
    NSDictionary *products;
}

static ProductsManager *sharedClassInstance = nil;

+ (ProductsManager *) sharedClass
{
	@synchronized(self)
    {
		if (!sharedClassInstance)
			sharedClassInstance = [[ProductsManager alloc] init];
        return sharedClassInstance;
	}
}

- (id)init
{
    self = [super init];
    if(self)
    {
        products = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"prodotti" ofType:@"plist"]];
    }
    
    return self;
}

- (NSArray*)listaTaglieri
{
    return [products objectForKey:@"taglieriList"];
}

- (NSDictionary*)taglieri
{
    return [products objectForKey:@"taglieri"];
}

- (NSDictionary*)tagliereConNome:(NSString*)nomeTagliere
{
    return [[products objectForKey:@"taglieri"]objectForKey:nomeTagliere];
}

- (NSArray*)listaHamburger
{
    return [products objectForKey:@"hamburgerList"];
}

- (NSDictionary*)hamburger
{
    return [products objectForKey:@"hamburgers"];
}

- (NSDictionary*)hamburgerConNome:(NSString *)nomeHamburger
{
    return [[products objectForKey:@"hamburgers"]objectForKey:nomeHamburger];
}

- (NSArray*)listaSecondi
{
    return [products objectForKey:@"secondiList"];
}

- (NSDictionary*)secondi
{
    return [products objectForKey:@"secondi"];
}

- (NSDictionary*)secondoConNome:(NSString*)nomeSecondo
{
    return [[products objectForKey:@"secondi"]objectForKey:nomeSecondo];
}

- (NSArray*)listaDessert
{
    return [products objectForKey:@"dessertList"];
}

- (NSDictionary*)dessert
{
    return [products objectForKey:@"dessert"];
}

- (NSDictionary*)dessertConNome:(NSString*)nomeDessert
{
    return [[products objectForKey:@"dessert"]objectForKey:nomeDessert];
}

- (NSArray*)listaPanini
{
    return [products objectForKey:@"paniniList"];
}

- (NSDictionary*)panini
{
    return [products objectForKey:@"panini"];
}

- (NSDictionary*)paninoConNome:(NSString*)nomePanino
{
    return [[products objectForKey:@"panini"]objectForKey:nomePanino];
}

- (NSArray*)listaStuzzichi
{
    return [products objectForKey:@"stuzzichiList"];
}

- (NSDictionary*)stuzzichi
{
    return [products objectForKey:@"stuzzichi"];
}

- (NSDictionary*)stuzzicoConNome:(NSString*)nomeStuzzico
{
    return [[products objectForKey:@"stuzzichi"]objectForKey:nomeStuzzico];
}

- (NSArray*)listaRustici
{
    return [products objectForKey:@"rusticiList"];
}

- (NSDictionary*)rustici
{
    return [products objectForKey:@"rustici"];
}

- (NSDictionary*)rusticoConNome:(NSString*)nomeRustico
{
    return [[products objectForKey:@"rustici"]objectForKey:nomeRustico];
}

- (NSArray*)listaPiadine
{
    return [products objectForKey:@"piadineList"];
}

- (NSDictionary*)piadine
{
    return [products objectForKey:@"piadine"];
}

- (NSDictionary*)piadinaConNome:(NSString*)nomePiadina
{
    return [[products objectForKey:@"piadine"]objectForKey:nomePiadina];
}

@end
