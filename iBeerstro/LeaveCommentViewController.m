//
//  LeaveCommentViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 06/09/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "LeaveCommentViewController.h"

#import "CommentCell.h"

#import "RateView.h"

@interface LeaveCommentViewController ()
{
    NSMutableData *responseData;
    NSMutableArray *commentsArray;
}
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (weak, nonatomic) IBOutlet RateView *rateView;

@end

@implementation LeaveCommentViewController

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
    
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    
    responseData = [NSMutableData data];
    commentsArray = [[NSMutableArray alloc]init];
    
    [self loadComments];
}

- (void)loadComments
{
    NSString *url = @"http://www.beerstro.it/load_comments.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *post =[[NSString alloc] initWithFormat:@"product=%@",_productName];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (IBAction)leaveCommentButtonPressed:(id)sender
{
    [_commentTextView resignFirstResponder];
    [[LeaveComment sharedClass]leaveComment:_commentTextView.text from:@"Alessio" about:_productName];
    [self performSelector:@selector(loadComments) withObject:nil afterDelay:2];
}

- (IBAction)voteButtonPressed:(id)sender
{
    NSLog(@"Voto: %f", [_rateView rating]);
    [[LeaveComment sharedClass] voteWith:[_rateView rating] from:@"Alessio" about:_productName];
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
    NSArray *res = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    responseData = [NSMutableData data];
    
    commentsArray = [NSMutableArray arrayWithArray:res];
    
    [_commentsTableView reloadData];
    
    NSLog(@"RISULTATO: %@", res);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commentsArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIdentifier=@"commentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = (CommentCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [[commentsArray objectAtIndex:indexPath.row]objectForKey:@"comment"];
    cell.detailTextLabel.text = [[commentsArray objectAtIndex:indexPath.row]objectForKey:@"username"];
    return cell;
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
