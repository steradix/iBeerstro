//
//  ProductViewController.h
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Taglieri,
    Hamburger,
    Secondi,
    Dessert,
    Panini,
    Stuzzichi,
    Rustici,
    Piadine
} TipoCucina;

@interface ProductViewController : UIViewController
{
    TipoCucina tp;
}

- (void)setTipoCucina:(TipoCucina)tipo;
- (TipoCucina)getTipoCucina;

@end
