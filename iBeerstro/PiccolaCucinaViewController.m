//
//  PiccolaCucinaViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 21/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "PiccolaCucinaViewController.h"
#import "ProductViewController.h"

@interface PiccolaCucinaViewController ()

@end

@implementation PiccolaCucinaViewController

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
    
    self.title = @"La piccola cucina";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenuButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenMenu" object:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"secondi"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Secondi];
    }
    else if([segue.identifier isEqualToString:@"hamburger"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Hamburger];
    }
    else if([segue.identifier isEqualToString:@"taglieri"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Taglieri];
    }
    else if([segue.identifier isEqualToString:@"dessert"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Dessert];
    }
    else if([segue.identifier isEqualToString:@"panini"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Panini];
    }
    else if([segue.identifier isEqualToString:@"stuzzichi"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Stuzzichi];
    }
    else if([segue.identifier isEqualToString:@"rustici"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Rustici];
    }
    else if([segue.identifier isEqualToString:@"piadine"])
    {
        ProductViewController * pvc = segue.destinationViewController;
        [pvc setTipoCucina:Piadine];
    }
}

@end
