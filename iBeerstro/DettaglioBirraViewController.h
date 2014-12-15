//
//  SingleBeerViewController.h
//  iBeerstro
//
//  Created by Stefano Radice on 20/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DettaglioBirraViewController : UIViewController

@property (strong, nonatomic) Birra *beer;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end
