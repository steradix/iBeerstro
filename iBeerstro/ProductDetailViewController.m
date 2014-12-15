//
//  ProductDetailViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "LeaveCommentViewController.h"

#define kdescription @"description"
#define kimageName @"imageName"

@interface ProductDetailViewController ()
{
    NSMutableData *responseData;
    NSMutableArray *commentsArray;
}
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ProductDetailViewController

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
    commentsArray = [[NSMutableArray alloc]init];
    
//    self.title = _productName;
    
    if([_product objectForKey:kimageName])
        [_myImageView setImage:[UIImage imageNamed:[_product objectForKey:kimageName]]];
    [_myTextView setText:[_product objectForKey:kdescription]];
    [self loadRating];
}

- (void)loadRating
{
    
    NSString *url = @"http://www.beerstro.it/media_voti.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *post =[[NSString alloc] initWithFormat:@"product=%@",_productName];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
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
    
    NSArray *res = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    responseData = [NSMutableData data];
    commentsArray = [NSMutableArray arrayWithArray:res];
    
    
  //  _statusLabel.text = [[commentsArray objectAtIndex:0]objectForKey:@"average"];
    
    NSLog(@"RISULTATO: %@", res);
    NSLog(@"RISULTATO: %@", commentsArray);
}


- (void)viewWillAppear:(BOOL)animated
{
    [_myTextView setFont:[UIFont fontWithName:@"Heiti TC" size:16.f]];
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
    LeaveCommentViewController * lcvc = (LeaveCommentViewController*)segue.destinationViewController;
    [lcvc setProductName:_productName];
}




@end

