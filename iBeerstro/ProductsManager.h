//
//  ProductsManager.h
//  iBeerstro
//
//  Created by Stefano Radice on 21/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DessertClass.h"
#import "TagliereClass.h"
#import "HamburgerClass.h"
#import "SecondoClass.h"
#import "PaninoClass.h"
#import "RusticoClass.h"
#import "StuzzicoClass.h"
#import "PiadinaClass.h"

@protocol ProductsManagerDelegate <NSObject>

- (void)dataLoaded:(NSArray*)data;

@end

@interface ProductsManager : NSObject

@property (assign, nonatomic) id <ProductsManagerDelegate> delegate;

+ (ProductsManager *)sharedClass;

- (void)getDessertsFromServer;
- (NSDictionary*)convertDessertIntoDictionary:(DessertClass*)dessert;

- (void)getTaglieriFromServer;
- (NSDictionary*)convertTagliereIntoDictionary:(TagliereClass*)tagliere;

- (void)getHamburgerFromServer;
- (NSDictionary*)convertHamburgerIntoDictionary:(HamburgerClass*)hamburger;

- (void)getSecondiFromServer;
- (NSDictionary*)convertSecondoIntoDictionary:(SecondoClass*)secondo;

- (void)getPaniniFromServer;
- (NSDictionary*)convertPaninoIntoDictionary:(PaninoClass*)panino;

- (void)getRusticiFromServer;
- (NSDictionary*)convertRusticoIntoDictionary:(RusticoClass*)rustico;

- (void)getStuzzichiFromServer;
- (NSDictionary*)convertStuzzicoIntoDictionary:(StuzzicoClass*)stuzzico;

- (void)getPiadineFromServer;
- (NSDictionary*)convertPiadinaIntoDictionary:(PiadinaClass*)piadina;

@end
