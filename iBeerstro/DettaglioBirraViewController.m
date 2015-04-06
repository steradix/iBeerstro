//
//  SingleBeerViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 20/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "DettaglioBirraViewController.h"

@interface DettaglioBirraViewController ()

@end

@implementation DettaglioBirraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *text = [NSString stringWithFormat:@"Bicchiere: %@\nStile: %@\nTemperatura: %@%°\nGradazione: %@%%\nBirrificio: %@\nProvenienza: %@", _beer.bicchiere, _beer.stile, _beer.temperatura , _beer.gradazione, _beer.birrificio, _beer.provenienza];
    [_myTextView setText:text];
    [_myTextView setFont:[UIFont fontWithName:@"Heiti TC" size:24]];
    
    [_myImageView setImageWithURL:[NSURL URLWithString:_beer.medaglione]
                                 placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
