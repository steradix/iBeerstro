//
//  DettaglioBirreViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "BeersPageViewController.h"
#import "DettaglioBirraViewController.h"

@interface BeersPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation BeersPageViewController

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
    
    self.delegate = self;
    self.dataSource = self;
    
    self.title = _startingBeer.nome;
    
    DettaglioBirraViewController *startingViewController = [self viewControllerAtIndex:[self indexOfBeer:_startingBeer] storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (IBAction)shareBeer:(id)sender
{
    DettaglioBirraViewController * dbvc = [self.childViewControllers objectAtIndex:0];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:dbvc.myImageView.image, dbvc.myTextView.text, nil] applicationActivities:nil];
    
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         if(completed)
         {
             //             NSLog(@"Type: %@", activityType);
             NSString * message;
             if([activityType isEqualToString:@"com.apple.UIKit.activity.CopyToPasteboard"])
                 message = @"Birra copiata negli appunti";
             else if([activityType isEqualToString:@"com.apple.UIKit.activity.Mail"])
                 message = @"Condivisione tramite mail avvenuta con successo";
             else if([activityType isEqualToString:@"com.apple.UIKit.activity.Message"])
                 message = @"Condivisione tramite messaggio avvenuta con successo";
             else if([activityType isEqualToString:@"com.apple.UIKit.activity.PostToFacebook"])
                 message = @"Condivisione su Facebook avvenuta con successo";
             else if([activityType isEqualToString:@"com.apple.UIKit.activity.PostToTwitter"])
                 message = @"Condivisione su Twitter avvenuta con successo";
             
             UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [alert show];
         }
         else
         {
             UIAlertView * myAlert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Operazione annullata"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
             [myAlert show];
         }
     }];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    UIViewController *currentViewController = self.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DettaglioBirraViewController *)viewController];
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DettaglioBirraViewController *)viewController];
    if (index == NSNotFound)
    {
        return nil;
    }
    
    index++;
    if (index == [self.beersList count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (DettaglioBirraViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    
    if (([self.beersList count] == 0) || (index >= [self.beersList count]))
    {
        return nil;
    }
    
    DettaglioBirraViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DettaglioBirraViewController"];
    dataViewController.beer = self.beersList[index];
    dataViewController.view.tag = index;
    return dataViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.title = ((DettaglioBirraViewController*)[pageViewController.viewControllers objectAtIndex:0]).beer.nome;
}

- (NSUInteger)indexOfViewController:(DettaglioBirraViewController *)viewController
{
    return [self.beersList indexOfObject:viewController.beer];
}

- (NSUInteger)indexOfBeer:(Birra *)beer
{
    return [self.beersList indexOfObject:beer];
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
