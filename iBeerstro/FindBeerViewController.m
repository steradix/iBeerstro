//
//  FindBeerViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 28/03/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import "FindBeerViewController.h"
#import "FoundResultTableViewController.h"

@interface FindBeerViewController ()

@end

@implementation FindBeerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cercaButtonPressed:(id)sender
{
    
    
    [self performSegueWithIdentifier:@"findBeer" sender:self];
}

- (IBAction)openMenuButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenMenu" object:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"findBeer"])
    {
        
        NSArray *testArray = [NSArray arrayWithObjects:@"Prima Birra", @"Seconda Birra", nil];
        FoundResultTableViewController *frtvc = (FoundResultTableViewController*)[segue destinationViewController];
        [frtvc setResults:testArray];
    }
}

@end
