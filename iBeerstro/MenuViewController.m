//
//  MenuViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 19/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UIGestureRecognizerDelegate>
{
    UIViewController *currentController;
    BOOL rightSwipe;
    
    UIView *grabView;
}

@end

@implementation MenuViewController

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
    
    if(![[ConnectionChecker sharedClass]checkInternetConnection])
    {
        NSLog(@"No Connection");
    }
    
    grabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, self.view.frame.size.height)];
    [grabView setBackgroundColor:[UIColor clearColor]];
    [grabView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapOnGrab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnGrabRecognized:)];
    [tapOnGrab setNumberOfTapsRequired:1];
    [tapOnGrab setNumberOfTouchesRequired:1];
    
    [grabView addGestureRecognizer:tapOnGrab];
    
    currentController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"newsNavigationController"];
    [self.view addSubview:currentController.view];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognized:)];
    [pan setMinimumNumberOfTouches:1];
    [pan setMaximumNumberOfTouches:1];
    [currentController.view addGestureRecognizer:pan];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openMenuButtonPressed) name:@"OpenMenu" object:nil];
}

- (void)openMenuButtonPressed
{
    [UIView animateWithDuration:0.5 animations:^{
        [currentController.view setFrame:CGRectMake(self.view.frame.size.width - 50, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [currentController.view addSubview:grabView];
    }];
}

- (void)tapOnGrabRecognized:(UITapGestureRecognizer*)gesture
{
    [UIView animateWithDuration:0.5 animations:^{
        [currentController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [grabView removeFromSuperview];
    }];
}

- (void)panRecognized:(UIPanGestureRecognizer*)gesture
{
    if([gesture state] == UIGestureRecognizerStateBegan)
    {
        rightSwipe = YES;
    }
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gesture translationInView:self.view];
        
        if(!(currentController.view.frame.origin.x + translation.x < 0))
        {
            [currentController.view setCenter:CGPointMake([currentController.view center].x + translation.x, [currentController.view center].y)];
            
            rightSwipe = ((translation.x > 0) ? YES : NO);
        }
        [gesture setTranslation:CGPointZero inView:currentController.view];
    }
    else if([gesture state] == UIGestureRecognizerStateEnded)
    {
        if(rightSwipe)
        {
            [UIView animateWithDuration:0.5 animations:^{
                [currentController.view setFrame:CGRectMake(self.view.frame.size.width - 50, 0, self.view.frame.size.width, self.view.frame.size.height)];
                [currentController.view addSubview:grabView];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                [currentController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                [grabView removeFromSuperview];
            }];
        }
    }
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
    [UIView animateWithDuration:0.25 animations:^{
        [currentController.view setFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL finished) {
        [currentController.view removeFromSuperview];
        currentController = nil;
        if([segue.identifier isEqualToString:@"NewsSegue"])
        {
            currentController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"newsNavigationController"];
        }
        else if([segue.identifier isEqualToString:@"BeersSegue"])
        {
            currentController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"beersNavigationController"];
        }
        else if([segue.identifier isEqualToString:@"PiccolaCucinaSegue"])
        {
            currentController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"piccolaCucinaNavigationController"];
        }
        else if([segue.identifier isEqualToString:@"ComeRaggiungerciSegue"])
        {
            currentController = [self.storyboard instantiateViewControllerWithIdentifier:@"comeRaggiungerciViewController"];
        }
        else if([segue.identifier isEqualToString:@"ContattiSegue"])
        {
            currentController = [self.storyboard instantiateViewControllerWithIdentifier:@"contattiViewController"];
        }
        else if([segue.identifier isEqualToString:@"LoginSegue"])
        {
            currentController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        }
        
        [currentController.view setFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognized:)];
        [pan setMinimumNumberOfTouches:1];
        [pan setMaximumNumberOfTouches:1];
        [currentController.view addGestureRecognizer:pan];
        
        [self.view addSubview:currentController.view];
        
        [UIView animateWithDuration:0.25 animations:^{
            [currentController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }];
}

@end
