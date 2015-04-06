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
    TipoCucina currentFoodType;
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

#pragma mark - FetchedData

- (void)fetchedData:(NSData *)responseData
{
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData
                     options:kNilOptions error:nil];
    NSMutableArray *prod = [[NSMutableArray alloc] initWithCapacity:[json count]];
    
    if(currentFoodType == Dessert)
    {
        for (NSDictionary *dict in json)
        {
            DessertClass *d = [[DessertClass alloc] init];
            
            d.identification    = [dict objectForKey:@"id"];
            d.nome              = [dict objectForKey:@"nome"];
            d.descrizione       = [dict objectForKey:@"descrizione"];
            d.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:d];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Taglieri)
    {
        for (NSDictionary *dict in json)
        {
            TagliereClass *t = [[TagliereClass alloc] init];
            
            t.identification    = [dict objectForKey:@"id"];
            t.nome              = [dict objectForKey:@"nome"];
            t.descrizione       = [dict objectForKey:@"descrizione"];
            t.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:t];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Hamburger)
    {
        for (NSDictionary *dict in json)
        {
            HamburgerClass *h = [[HamburgerClass alloc] init];
            
            h.identification    = [dict objectForKey:@"id"];
            h.nome              = [dict objectForKey:@"nome"];
            h.descrizione       = [dict objectForKey:@"descrizione"];
            h.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:h];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Secondi)
    {
        for (NSDictionary *dict in json)
        {
            SecondoClass *s = [[SecondoClass alloc] init];
            
            s.identification    = [dict objectForKey:@"id"];
            s.nome              = [dict objectForKey:@"nome"];
            s.descrizione       = [dict objectForKey:@"descrizione"];
            s.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:s];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Panini)
    {
        for (NSDictionary *dict in json)
        {
            PaninoClass *p = [[PaninoClass alloc] init];
            
            p.identification    = [dict objectForKey:@"id"];
            p.nome              = [dict objectForKey:@"nome"];
            p.descrizione       = [dict objectForKey:@"descrizione"];
            p.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:p];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Rustici)
    {
        for (NSDictionary *dict in json)
        {
            RusticoClass *r = [[RusticoClass alloc] init];
            
            r.identification    = [dict objectForKey:@"id"];
            r.nome              = [dict objectForKey:@"nome"];
            r.descrizione       = [dict objectForKey:@"descrizione"];
            r.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:r];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Stuzzichi)
    {
        for (NSDictionary *dict in json)
        {
            StuzzicoClass *s = [[StuzzicoClass alloc] init];
            
            s.identification    = [dict objectForKey:@"id"];
            s.nome              = [dict objectForKey:@"nome"];
            s.descrizione       = [dict objectForKey:@"descrizione"];
            s.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:s];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
    else if(currentFoodType == Piadine)
    {
        for (NSDictionary *dict in json)
        {
            PiadinaClass *p = [[PiadinaClass alloc] init];
            
            p.identification    = [dict objectForKey:@"id"];
            p.nome              = [dict objectForKey:@"nome"];
            p.descrizione       = [dict objectForKey:@"descrizione"];
            p.immagine          = [dict objectForKey:@"immagine"];
            
            [prod addObject:p];
        }
        
        if([self.delegate respondsToSelector:@selector(dataLoaded:)])
            [self.delegate dataLoaded:prod];
    }
}

#pragma mark - Dessert

- (void)getDessertsFromServer
{
    currentFoodType = Dessert;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/dessert.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertDessertIntoDictionary:(DessertClass*)dessert
{
    NSMutableDictionary *des = [[NSMutableDictionary alloc]init];
    
    [des setObject:dessert.nome forKey:@"nome"];
    [des setObject:dessert.descrizione forKey:@"descrizione"];
    [des setObject:dessert.immagine forKey:@"immagine"];
    
    return des.copy;
}

#pragma mark - Taglieri

- (void)getTaglieriFromServer
{
    currentFoodType = Taglieri;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/tagliere.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertTagliereIntoDictionary:(TagliereClass*)tagliere
{
    NSMutableDictionary *tag = [[NSMutableDictionary alloc]init];
    
    [tag setObject:tagliere.nome forKey:@"nome"];
    [tag setObject:tagliere.descrizione forKey:@"descrizione"];
    [tag setObject:tagliere.immagine forKey:@"immagine"];
    
    return tag.copy;
}

#pragma mark - Hamburger

- (void)getHamburgerFromServer
{
    currentFoodType = Hamburger;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/hamburger.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertHamburgerIntoDictionary:(HamburgerClass*)hamburger
{
    NSMutableDictionary *ham = [[NSMutableDictionary alloc]init];
    
    [ham setObject:hamburger.nome forKey:@"nome"];
    [ham setObject:hamburger.descrizione forKey:@"descrizione"];
    [ham setObject:hamburger.immagine forKey:@"immagine"];
    
    return ham.copy;
}

#pragma mark - Secondi

- (void)getSecondiFromServer
{
    currentFoodType = Secondi;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/secondo.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertSecondoIntoDictionary:(SecondoClass*)secondo
{
    NSMutableDictionary *sec = [[NSMutableDictionary alloc]init];
    
    [sec setObject:secondo.nome forKey:@"nome"];
    [sec setObject:secondo.descrizione forKey:@"descrizione"];
    [sec setObject:secondo.immagine forKey:@"immagine"];
    
    return sec.copy;
}

#pragma mark - Panini

- (void)getPaniniFromServer
{
    currentFoodType = Panini;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/panino.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertPaninoIntoDictionary:(PaninoClass*)panino
{
    NSMutableDictionary *pan = [[NSMutableDictionary alloc]init];
    
    [pan setObject:panino.nome forKey:@"nome"];
    [pan setObject:panino.descrizione forKey:@"descrizione"];
    [pan setObject:panino.immagine forKey:@"immagine"];
    
    return pan.copy;
}

#pragma mark - Rustici

- (void)getRusticiFromServer
{
    currentFoodType = Rustici;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/rustico.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertRusticoIntoDictionary:(RusticoClass*)rustico
{
    NSMutableDictionary *rus = [[NSMutableDictionary alloc]init];
    
    [rus setObject:rustico.nome forKey:@"nome"];
    [rus setObject:rustico.descrizione forKey:@"descrizione"];
    [rus setObject:rustico.immagine forKey:@"immagine"];
    
    return rus.copy;
}

#pragma mark - Stuzzichi

- (void)getStuzzichiFromServer
{
    currentFoodType = Stuzzichi;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/stuzzico.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertStuzzicoIntoDictionary:(StuzzicoClass *)stuzzico
{
    NSMutableDictionary *stu = [[NSMutableDictionary alloc]init];
    
    [stu setObject:stuzzico.nome forKey:@"nome"];
    [stu setObject:stuzzico.descrizione forKey:@"descrizione"];
    [stu setObject:stuzzico.immagine forKey:@"immagine"];
    
    return stu.copy;
}

#pragma mark - Piadina

- (void)getPiadineFromServer
{
    currentFoodType = Piadine;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.beerstro.it/piadina.php"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    });
}

- (NSDictionary*)convertPiadinaIntoDictionary:(PiadinaClass *)piadina
{
    NSMutableDictionary *pia = [[NSMutableDictionary alloc]init];
    
    [pia setObject:piadina.nome forKey:@"nome"];
    [pia setObject:piadina.descrizione forKey:@"descrizione"];
    [pia setObject:piadina.immagine forKey:@"immagine"];
    
    return pia.copy;
}

@end
