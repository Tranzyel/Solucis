//
//  MenuViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-03-14.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCollectionViewCell.h"
#import "LeftSideRevealViewController.h"
#import "MenuSubItemTableViewCell.h"
#import "MCOMemberInfo.h"

static NSString *const MenuCollectionViewCellIdentifier = @"MenuCollectionViewCellIdentifier";
static NSString *const MenuSubItemTableViewCellIdentifier = @"MenuSubItemTableViewCellIdentifier";

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *memberCodeIdentityLbl;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"home_title", "");
    
    [self.menuCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MenuCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:MenuCollectionViewCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MenuSubItemTableViewCell class]) bundle:nil] forCellReuseIdentifier:MenuSubItemTableViewCellIdentifier];
    
    self.navigationItem.hidesBackButton = YES;
    
    [[RequestMgr shared] requestMemberInfo:nil completionBlock:^(id response)
     {
         MCOMemberInfo *info = (MCOMemberInfo*)response;
         
         self.memberCodeIdentityLbl.text = [[NSString stringWithFormat:@"%@ , %@",NSLocalizedString(@"home_welcome", ""),info.f_name] uppercaseString];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MenuCollectionViewCellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell.menuTitle.text = [NSLocalizedString(@"home_dashboard_title", "") uppercaseString];
            cell.icon.image = [UIImage imageNamed:@"btn-dashboard-1.png"];
            break;
        }
        case 1:
        {
            cell.menuTitle.text = [NSLocalizedString(@"home_repurchase_title", "") uppercaseString];
            cell.icon.image = [UIImage imageNamed:@"btn-repurchase-1.png"];
            break;
        }
        case 2:
        {
            cell.menuTitle.text = [NSLocalizedString(@"home_ePOINT_title", "") uppercaseString];
            cell.icon.image = [UIImage imageNamed:@"btn-eaccount-1.png"];
            break;
        }
        case 3:
        {
            cell.menuTitle.text = [NSLocalizedString(@"home_register_title", "") uppercaseString];
            cell.icon.image = [UIImage imageNamed:@"btn-register-con-1.png"];
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index;
    
    switch (indexPath.row)
    {
        case 0:
        {   index = Dashboard;
            break;
        }
        case 1:
        {   index = Repurchase;
            break;
        }
        case 2:
        {   index = EPoint;
            break;
        }
        case 3:
        {   index = RegisterDistributor;
            break;
        }
        default:
        {
            index = Dashboard;
        }
            break;
    }
    
    [self.menuCollectionView.collectionViewLayout invalidateLayout];
    [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(index)];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(73.0f, 87.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (IS_IPHONE_5)
    {
        return 7.0;
    }
    else if (IS_IPHONE_6)
    {
        return 25.0;
    }
    else if (IS_IPHONE_6_PLUS)
    {
        return 38.0;
    }
    
    return 10;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 444;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuSubItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuSubItemTableViewCellIdentifier];
    
    for (UIButton *subMenuButton in cell.subMenus)
    {
        [subMenuButton addTarget:self action:@selector(subMenuItemDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    }

    cell.personalSalesHistoryLbl.text = [NSLocalizedString(@"home_personal_sales_history", "") uppercaseString];
    cell.allSalesHistoryLbl.text = [NSLocalizedString(@"home_all_sales_history", "") uppercaseString];
    cell.aboutUsLbl.text = [NSLocalizedString(@"home_about_us", "") uppercaseString];
    cell.exclusiveStoreListingLbl.text = [NSLocalizedString(@"home_exclusive_store_listing", "") uppercaseString];
    cell.distributorEPointLbl.text = [NSLocalizedString(@"home_distributor_ePoint", "") uppercaseString];
    cell.eAccountStatementLbl.text = [NSLocalizedString(@"home_eAccount_statement", "") uppercaseString];
    cell.eAccountTransferLbl.text = [NSLocalizedString(@"home_eAccount_transfer", "") uppercaseString];
    cell.salesBonusLbl.text = [NSLocalizedString(@"home_sales_bonus", "") uppercaseString];
    cell.announcementLbl.text = [NSLocalizedString(@"home_annoucement", "") uppercaseString];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - UIAction

- (void)subMenuItemDidSelect:(id)sender
{
    UIButton *button = (UIButton *)sender;    
    NSInteger index = button.tag;
    [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(index)];
}

@end
