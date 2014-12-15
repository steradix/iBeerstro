//
//  NewsDetailViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailViewController.h"
#import "News.h"

@interface NewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end


@implementation NewsDetailViewController

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
    
    self.title = _newsToShow.title;
    
    [_myTextView setText:_newsToShow.text];
    [_myTextView setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [_myImageView setImageWithURL:[NSURL URLWithString:_newsToShow.image]
                 placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
}

- (IBAction)shareNews:(id)sender
{
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:self.myImageView.image, self.myTextView.text, nil] applicationActivities:nil];
    
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         if(completed)
         {
             //             NSLog(@"Type: %@", activityType);
             NSString * message;
             if([activityType isEqualToString:@"com.apple.UIKit.activity.CopyToPasteboard"])
                 message = @"News copiata negli appunti";
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
