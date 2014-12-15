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

#import "DessertsManager.h"
#import "DessertClass.h"

@interface ProductViewController ()<UITableViewDataSource, UITableViewDelegate, DessertsManagerDelegate>
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
    switch (tp) {
        case Taglieri:
            productsNameList = [[ProductsManager sharedClass]listaTaglieri];
            break;
        case Hamburger:
            productsNameList = [[ProductsManager sharedClass]listaHamburger];
            break;
        case Secondi:
            productsNameList = [[ProductsManager sharedClass]listaSecondi];
            break;
        case Dessert:
//            productsNameList = [[ProductsManager sharedClass]listaDessert];
            [[DessertsManager sharedClass]setDelegate:self];
            [[DessertsManager sharedClass]getDessertsFromServer];
            break;
        case Panini:
            productsNameList = [[ProductsManager sharedClass]listaPanini];
            break;
        case Stuzzichi:
            productsNameList = [[ProductsManager sharedClass]listaStuzzichi];
            break;
        case Rustici:
            productsNameList = [[ProductsManager sharedClass]listaRustici];
            break;
        case Piadine:
            productsNameList = [[ProductsManager sharedClass]listaPiadine];
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
            selectedProduct = [[ProductsManager sharedClass]tagliereConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] taglieri];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaTaglieri];
            break;
        case Hamburger:
            selectedProduct = [[ProductsManager sharedClass]hamburgerConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] hamburger];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaHamburger];
            break;
        case Secondi:
            selectedProduct = [[ProductsManager sharedClass]secondoConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] secondi];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaSecondi];
            break;
        case Dessert:
//            selectedProduct = [[ProductsManager sharedClass]dessertConNome:[productsNameList objectAtIndex:indexPath.row]];
//            pdvc.dataList = [[ProductsManager sharedClass] dessert];
//            pdvc.listOfProducts = [[ProductsManager sharedClass] listaDessert];
            
            selectedProduct = [[DessertsManager sharedClass]convertDessertIntoDictionary:[productsListDownloaded objectAtIndex:indexPath.row]];
            pdvc.dataList = productsDownloaded;
            pdvc.listOfProducts = productsNameList;
            
            break;
        case Panini:
            selectedProduct = [[ProductsManager sharedClass]paninoConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] panini];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaPanini];
            break;
        case Stuzzichi:
            selectedProduct = [[ProductsManager sharedClass]stuzzicoConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] stuzzichi];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaStuzzichi];
            break;
        case Rustici:
            selectedProduct = [[ProductsManager sharedClass]rusticoConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] rustici];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaRustici];
            break;
        case Piadine:
            selectedProduct = [[ProductsManager sharedClass]piadinaConNome:[productsNameList objectAtIndex:indexPath.row]];
            pdvc.dataList = [[ProductsManager sharedClass] piadine];
            pdvc.listOfProducts = [[ProductsManager sharedClass] listaPiadine];
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
    
    for(DessertClass *d in data)
    {
        [names addObject:d.nome];
        [products setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:d.descrizione, d.immagine, nil] forKeys:[NSArray arrayWithObjects:@"description", @"imageName", nil]] forKey:d.nome];
    }
    
    productsNameList = names.copy;
    productsDownloaded = products.copy;
    
    [_myTableView reloadData];
}

@end
