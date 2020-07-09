    //
//  PreProductTableViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PreProductTableViewController.h"
#import "PreProductTableViewCell.h"
#import "MCOPlaceOrderModel.h"
#import "PreProductDetailsViewController.h"
#import <UIImageView+AFNetworking.h>

@interface PreProductTableViewController ()
@property (nonatomic , strong ) NSArray *preProductLists;
@end

static NSString *const PreProductTableViewCellIdentifier = @"PreProductTableViewCellIdentifier";

@implementation PreProductTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[RequestMgr shared] requestAllProductListWithCompletionBlock:^(id response)
    {
        self.preProductLists = [[LocalStorage shared] preProductList];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PreProductTableViewCell class]) bundle:nil] forCellReuseIdentifier:PreProductTableViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.preProductLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PreProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PreProductTableViewCellIdentifier forIndexPath:indexPath];
    
    MCOPlaceOrderModel *model = self.preProductLists[indexPath.row];
    
    cell.productName.text = model.name;
    cell.productBV.text = [NSString stringWithFormat:@"%.0f",[model.f_unit_bv floatValue]];//;
    cell.productPV.text = [NSString stringWithFormat:@"%.0f",[model.f_unit_pv floatValue]];
    cell.productPrice.text = model.products_aftax_price;
    cell.productGST.text = model.f_unit_tax;
    cell.productShortDetails.text = model.products_short_description;
    
    if (model.productImage == nil)
    {
        NSString *imageURL = [model.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

        [cell.productImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
        {
            cell.productImage.image = image;
            model.productImage = image;
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    else
    {
        cell.productImage.image = model.productImage;
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MCOPlaceOrderModel *model = self.preProductLists[indexPath.row];
    
    PreProductDetailsViewController *detailViewController = [[PreProductDetailsViewController alloc] initWithNibName:@"PreProductDetailsViewController" bundle:nil];
    detailViewController.title = [NSLocalizedString(@"pre_login_products_title", "") uppercaseString];
    detailViewController.productDetails = model.products_description;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showBackButton
{
    self.navigationItem.hidesBackButton = YES;
    
    UIImage * backButtonImage = [UIImage imageNamed: @"ic-back.png"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped:)];
    [backButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backButton;
}


- (void)backButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
