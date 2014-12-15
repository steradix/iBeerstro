//
//  BeersViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 19/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "BirreViewController.h"
#import "DettaglioBirraViewController.h"
#import "BeersPageViewController.h"

#import "CustomCell.h"

@interface BirreViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, BeersManagerDelegate>
{
    NSArray *beers;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingBeers;

@end

@implementation BirreViewController

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
    
    [[BeersManager sharedClass]setDelegate:self];
    [[BeersManager sharedClass]getBeersFromServer];
    
    self.title = @"Le birre";
}

- (void)viewDidAppear:(BOOL)animated
{
//    beers = [[BeersManager sharedClass]getBeersFromServer];
//    [self.myCollection reloadData];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return beers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __block CustomCell * cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __block Birra * beer = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (beers)
        {
            beer = [beers objectAtIndex:indexPath.row];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.myImageView setImageWithURL:[NSURL URLWithString:beer.medaglione]
                             placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            return;
        });
    });
    return cell;
}

- (void)dataLoaded:(NSArray *)data
{
    [_loadingBeers stopAnimating];
    if (!data)
    {
        UIAlertView * myAlert = [[UIAlertView alloc] initWithTitle:@"Errore!"
                                                           message:@"Non è stato possibile contattare il server. Assicurati di avere una connessione ad internet attiva e riprova."
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
        [myAlert show];
        return;
    }
    
    beers = [NSArray arrayWithArray:data];
    [self.myCollection reloadData];
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
    if([segue.identifier isEqualToString:@"beerDetail"])
    {
//        DettaglioBirraViewController * singleBeer = segue.destinationViewController;
//        UICollectionViewCell * cell = (UICollectionViewCell*)sender;
//        NSIndexPath * indexPath = [_myCollection indexPathForItemAtPoint:[_myCollection convertPoint:cell.center fromView:cell.superview]];
//        singleBeer.beer = (Birra*)[beers objectAtIndex:indexPath.row];
        
        BeersPageViewController * singleBeer = segue.destinationViewController;
        singleBeer.beersList = beers;
        
        UICollectionViewCell * cell = (UICollectionViewCell*)sender;
        NSIndexPath * indexPath = [_myCollection indexPathForItemAtPoint:[_myCollection convertPoint:cell.center fromView:cell.superview]];
        singleBeer.startingBeer = (Birra*)[beers objectAtIndex:indexPath.row];
    }
}

@end
