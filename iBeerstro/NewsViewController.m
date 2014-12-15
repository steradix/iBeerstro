//
//  NewsViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 19/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "NewsViewController.h"
#import "CustomCell.h"
#import "NewsDetailViewController.h"

@interface NewsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, NewsManagerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation NewsViewController
{
    NSArray *news;
}

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
    
    [[NewsManager sharedClass] setDelegate:self];
    [[NewsManager sharedClass] getNewsFromServer];
    
    self.title = @"NEWS";
}

- (IBAction)openMenuButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenMenu" object:nil];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if(!news)   return 0;
    else return news.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __block CustomCell * cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __block News * newNews = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (news)
        {
            newNews = [news objectAtIndex:indexPath.row];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.myImageView setImageWithURL:[NSURL URLWithString:newNews.image] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            return;
        });
    });
    return cell;
}

#pragma mark - NewsManagerDelegate

- (void)dataLoaded:(NSArray *)data
{
    news = data;
    [_myCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"newsDetail"])
    {
        NewsDetailViewController * ndvc = segue.destinationViewController;
        UICollectionViewCell * cell = (UICollectionViewCell*)sender;
        NSIndexPath * indexPath = [_myCollectionView indexPathForItemAtPoint:[_myCollectionView convertPoint:cell.center fromView:cell.superview]];
        ndvc.newsToShow = (News*)[news objectAtIndex:indexPath.row];
    }
}

@end
