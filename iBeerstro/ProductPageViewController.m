//
//  ProductPageViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 23/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "ProductPageViewController.h"
#import "ProductDetailViewController.h"

@interface ProductPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation ProductPageViewController

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
    
    self.title = _nameOfProduct;
    
    ProductDetailViewController *startingViewController = [self viewControllerAtIndex:[self indexOfObject:_nameOfProduct] storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonPressed:(id)sender
{
    ProductDetailViewController * pdvc = [self.childViewControllers objectAtIndex:0];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:pdvc.myImageView.image, pdvc.myTextView.text, nil] applicationActivities:nil];
    
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

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    UIViewController *currentViewController = self.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ProductDetailViewController *)viewController];
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ProductDetailViewController *)viewController];
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [self.dataList count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (ProductDetailViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    
    if (([self.dataList count] == 0) || (index >= [self.dataList count]))
    {
        return nil;
    }
    
    ProductDetailViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    dataViewController.product = [_dataList objectForKey:[_listOfProducts objectAtIndex:index]];
    dataViewController.productName = [_listOfProducts objectAtIndex:index];
    dataViewController.view.tag = index;
    return dataViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.title = ((ProductDetailViewController*)[pageViewController.viewControllers objectAtIndex:0]).productName;
}

- (NSUInteger)indexOfViewController:(ProductDetailViewController *)viewController
{
    return [self.listOfProducts indexOfObject:viewController.productName];
}

- (NSUInteger)indexOfObject:(NSString *)object
{
    return [self.listOfProducts indexOfObject:object];
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
