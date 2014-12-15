//
//  ContattiViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "ContattiViewController.h"

@interface ContattiViewController ()<UIAlertViewDelegate>

@end

@implementation ContattiViewController

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
}

- (IBAction)openMenuButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenMenu" object:nil];
}

- (IBAction)chiamaBeerstro:(id)sender
{
    if(![[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
    {
        UIAlertView * myAlert = [[UIAlertView alloc] initWithTitle:@"Ops"
                                                           message:@"Il tuo dispositivo non è abilitato a telefonare!"
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
        [myAlert show];
    }
    else
    {
        UIAlertView * myAlert = [[UIAlertView alloc] initWithTitle:nil
                                                           message:@"Vuoi davvero chiamare?"
                                                          delegate:self
                                                 cancelButtonTitle:@"No"
                                                 otherButtonTitles:@"Si", nil];
        [myAlert show];
    }
}
- (IBAction)facebookButtonPressed:(id)sender
{
    NSURL * url = [NSURL URLWithString:@"fb://profile/293523427384381"];
    if (![[UIApplication sharedApplication] canOpenURL:url])
        url = [[NSURL alloc]initWithString:@"http://www.facebook.com/Beerstro"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != alertView.cancelButtonIndex)
    {
        NSString *phoneNumber = @"tel://0299068348";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
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
