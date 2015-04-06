//
//  LoginViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 07/06/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "SessionChecker.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username_email_field;
@property (weak, nonatomic) IBOutlet UITextField *password_field;

@end

@implementation LoginViewController
{
    NSMutableData *responseData;
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
    
    responseData = [NSMutableData data];
    
    self.title = @"LogIn";
}

- (IBAction)login:(id)sender
{
    NSString *url = @"http://www.beerstro.it/login.php";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@", _username_email_field.text, _password_field.text];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (IBAction)openMenuButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenMenu" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _username_email_field)
    {
        [_password_field becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}


#pragma mark - Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"ConnectionDidReceiveResponse: %@", response);
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@"ConnectionDidReceiveData");
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection didFailWithError: %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"ConnectionDidFinishLoading");
    
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSLog(@"RISULTATO: %@", res);
    
    [[SessionChecker sharedClass]checkSessionWithLogs];
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
