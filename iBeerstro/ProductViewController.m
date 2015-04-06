//
//  ProductViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductDetailViewController.h"
#import "ProductPageViewController.h"
#import "ProductsManager.h"

#import "DessertClass.h"
#import "TagliereClass.h"

@interface ProductViewController ()<UITableViewDataSource, UITableViewDelegate, ProductsManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ProductViewController
{
    NSArray *productsNameList;
    NSDictionary *selectedProduct;
    
    NSArray *productsListDownloaded;
    NSDictionary *productsDownloaded;
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
    NSString *title;
    
    switch (tp) {
        case Taglieri:
            title = @"I taglieri";
            break;
        case Hamburger:
            title = @"Gli hamburger";
            break;
        case Secondi:
            title = @"I secondi";
            break;
        case Dessert:
            title = @"I dessert";
            break;
        case Panini:
            title = @"I panini";
            break;
        case Stuzzichi:
            title = @"Gli stuzzichi";
            break;
        case Rustici:
            title = @"I rustici";
            break;
        case Piadine:
            title = @"Le piadine";
            break;
        default:
            break;
    }
    self.title = title;
    
    [_myTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sfondoCucina640x1136.jpg"]]];
}

#pragma mark - TipoCucina

- (void)setTipoCucina:(TipoCucina)tipo
{
    tp = tipo;
    [self populateProductsListArray];
}

- (TipoCucina)getTipoCucina
{
    return tp;
}

- (void)populateProductsListArray
{
    [[ProductsManager sharedClass]setDelegate:self];
    switch (tp) {
        case Taglieri:
            [[ProductsManager sharedClass]getTaglieriFromServer];
            break;
        case Hamburger:
            [[ProductsManager sharedClass]getHamburgerFromServer];
            break;
        case Secondi:
            [[ProductsManager sharedClass]getSecondiFromServer];
            break;
        case Dessert:
            [[ProductsManager sharedClass]getDessertsFromServer];
            break;
        case Panini:
            [[ProductsManager sharedClass]getPaniniFromServer];
            break;
        case Stuzzichi:
            [[ProductsManager sharedClass]getStuzzichiFromServer];
            break;
        case Rustici:
            [[ProductsManager sharedClass]getRusticiFromServer];
            break;
        case Piadine:
            [[ProductsManager sharedClass]getPiadineFromServer];
            break;
        default:
            break;
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productsNameList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIdentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [productsNameList objectAtIndex:indexPath.row];
    return cell;
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
    ProductPageViewController * pdvc = segue.destinationViewController;
    UITableViewCell * cell = (UITableViewCell*)sender;
    NSIndexPath * indexPath = [_myTableView indexPathForCell:cell];
    
    switch (tp) {
        case Taglieri:
            selectedProduct = [[ProductsManager sharedClass]convertTagliereIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        case Hamburger:
            selectedProduct = [[ProductsManager sharedClass]convertHamburgerIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        case Secondi:
            selectedProduct = [[ProductsManager sharedClass]convertSecondoIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        case Dessert:
            selectedProduct = [[ProductsManager sharedClass]convertDessertIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            
            break;
        case Panini:
            selectedProduct = [[ProductsManager sharedClass]convertPaninoIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        case Stuzzichi:
            selectedProduct = [[ProductsManager sharedClass]convertStuzzicoIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        case Rustici:
            selectedProduct = [[ProductsManager sharedClass]convertRusticoIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        case Piadine:
            selectedProduct = [[ProductsManager sharedClass]convertPiadinaIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            break;
        default:
            break;
    }
    
    pdvc.nameOfProduct = [productsNameList objectAtIndex:indexPath.row];
}

#pragma mark - Delegate

- (void)dataLoaded:(NSArray *)data
{
    NSLog(@"data: %@", data);
    
    productsListDownloaded = data;
    
    NSMutableArray *names = [[NSMutableArray alloc]initWithCapacity:data.count];
    NSMutableDictionary *products = [[NSMutableDictionary alloc]init];
    
    if([[data objectAtIndex:0]isKindOfClass:DessertClass.class])
    {
        NSLog(@"Dessert");
        for(DessertClass *d in data)
        {
            [d logDessert];
            [names addObject:d.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:d.descrizione, d.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:d.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:TagliereClass.class])
    {
        NSLog(@"Taglieri");
        for(TagliereClass *t in data)
        {
            [t logTagliere];
            [names addObject:t.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:t.descrizione, t.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:t.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:HamburgerClass.class])
    {
        NSLog(@"Hamburger");
        for(HamburgerClass *h in data)
        {
            [h logHamburger];
            [names addObject:h.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:h.descrizione, h.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:h.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:SecondoClass.class])
    {
        NSLog(@"Secondo");
        for(SecondoClass *s in data)
        {
            [s logSecondo];
            [names addObject:s.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:s.descrizione, s.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:s.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:PaninoClass.class])
    {
        NSLog(@"Panino");
        for(PaninoClass *p in data)
        {
            [p logPanino];
            [names addObject:p.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:p.descrizione, p.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:p.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:RusticoClass.class])
    {
        NSLog(@"Rustico");
        for(RusticoClass *r in data)
        {
            [r logRustico];
            [names addObject:r.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:r.descrizione, r.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:r.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:StuzzicoClass.class])
    {
        NSLog(@"Stuzzico");
        for(StuzzicoClass *s in data)
        {
            [s logStuzzico];
            [names addObject:s.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:s.descrizione, s.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:s.nome];
        }
    }
    else if([[data objectAtIndex:0]isKindOfClass:PiadinaClass.class])
    {
        NSLog(@"Piadina");
        for(PiadinaClass *p in data)
        {
            [p logPiadina];
            [names addObject:p.nome];
            [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:p.descrizione, p.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:p.nome];
        }
    }
    
    productsNameList = names.copy;
    productsDownloaded = products.copy;
    
    [_myTableView reloadData];
}

@end
