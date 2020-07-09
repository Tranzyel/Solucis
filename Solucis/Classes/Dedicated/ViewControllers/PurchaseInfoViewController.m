//
//  PurchaseInfoViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PurchaseInfoViewController.h"
#import "MemberCell.h"
#import "MemberHeaderView.h"
#import "PurchaseInfoItemTableViewCell.h"
#import "MCOPlaceOrderModel.h"
#import "MCOMemberInfo.h"

static NSString *const MemberCellIdentifier = @"MemberCellIdentifier";
static NSString *const PurchaseInfoItemTableViewCellIdentifier = @"PurchaseInfoItemTableViewCellIdentifier";

@interface PurchaseInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property ( nonatomic , strong ) MemberHeaderView *headerView;
@property (strong, nonatomic) IBOutlet UIView *billSummaryView;
@property (weak, nonatomic) IBOutlet UILabel *subTotal;
@property (weak, nonatomic) IBOutlet UILabel *gst;
@property (weak, nonatomic) IBOutlet UILabel *deliveryCharges;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (nonatomic, assign) CGRect billSummaryOriginalFrame;
@property (nonatomic, assign) BOOL summaryViewShown;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

- (IBAction)billSummaryDidTouchUp:(id)sender;

//Localization
@property (weak, nonatomic) IBOutlet UIButton *bullSummaryButton;
@property (weak, nonatomic) IBOutlet UILabel *subTotalLoc;
@property (weak, nonatomic) IBOutlet UILabel *gstLoc;
@property (weak, nonatomic) IBOutlet UILabel *deliveryChargesLoc;
@property (weak, nonatomic) IBOutlet UILabel *totalIncGSTLoc;


@end

@implementation PurchaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.nextPageButton setTitle:NSLocalizedString(@"title_next_button", "") forState:UIControlStateNormal];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberCell class]) bundle:nil] forCellReuseIdentifier:MemberCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PurchaseInfoItemTableViewCell class]) bundle:nil] forCellReuseIdentifier:PurchaseInfoItemTableViewCellIdentifier];
    
    {
        [self.bullSummaryButton setTitle:NSLocalizedString(@"rep_bill_summary", "") forState:UIControlStateNormal];
        self.subTotalLoc.text = NSLocalizedString(@"rep_subtotal", "");
        self.gstLoc.text = NSLocalizedString(@"rep_gst", "");
        self.deliveryChargesLoc.text = NSLocalizedString(@"rep_delivery_charges", "");
        self.totalIncGSTLoc.text = NSLocalizedString(@"rep_total_include_gst", "");
    }
    
    [self populateDataInSummaryView];
    [self requestOrderSummary];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.type == DistributorTypeRegistration)
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_purchase_info", "") currentPage:5 totalPage:TOTAL_PAGES_RD];
    }
    else
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_purchase_info", "") currentPage:4 totalPage:TOTAL_PAGES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.billSummaryOriginalFrame = self.billSummaryView.frame;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.summaryViewShown)
    {
        self.summaryViewShown = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.billSummaryView.frame = self.billSummaryOriginalFrame;
            [self.arrowImage setImage:[UIImage imageNamed:@"arrow-up-white.png"]];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[MemberHeaderView alloc] initNib];
    
    if (section == 0)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"rep_member_details_header", "");
    }
    else
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"rep_order_summary_header", "");
    }
    
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return 62.0;
        }
        case 1:
        {
            return 170.0;
        }
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
        case 1:
        {
            return [[LocalStorage shared] tempPlaceOrderArray].count;
        }
        default:
        {
            break;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:MemberCellIdentifier];
        MCOMemberInfo *memberInfo = [[LocalStorage shared] memberInfo];
        switch (indexPath.row)
        {
            case 0:
            {
                cell.titleLbl.text = NSLocalizedString(@"rep_member_id", "");
                cell.descriptionLbl.text = memberInfo.f_code;
                break;
            }
            case 1:
            {
                cell.titleLbl.text = NSLocalizedString(@"rep_member_name", "");
                cell.descriptionLbl.text = memberInfo.f_name;
                break;
            }
            default:
            {
                break;
            }
        }

        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        PurchaseInfoItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PurchaseInfoItemTableViewCellIdentifier];
        
        MCOPlaceOrderModel *model = [[LocalStorage shared] tempPlaceOrderArray][indexPath.row];
        
        cell.itemName.text = model.name;
        cell.itemGST.text = model.f_unit_tax;
        cell.itemPrice.text = model.products_aftax_price;
        cell.totalItem.text = [NSString stringWithFormat:@"%lu",(long)model.totalSelectedItem];
        cell.unitBV.text = model.f_unit_bv;
        cell.unitPV.text = model.f_unit_pv;
        cell.totalPrice.text = [NSString stringWithFormat:@"%.2f",(float)model.itemTotalPrice];
        cell.itemImage.image = model.productImage;
        return cell;
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate


- (IBAction)billSummaryDidTouchUp:(id)sender
{
    [self showBillSummaryView:!self.summaryViewShown];
}

- (void)showBillSummaryView:(BOOL)show
{
    if (show)
    {
        self.summaryViewShown = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.billSummaryView.frame = CGRectMake(0, self.billSummaryView.frame.origin.y - self.billSummaryView.frame.size.height + 40, self.billSummaryView.frame.size.width, self.billSummaryView.frame.size.height);
            
            [self.arrowImage setImage:[UIImage imageNamed:@"arrow-down-white.png"]];
        }];
        
    }
    else
    {
        self.summaryViewShown = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.billSummaryView.frame = self.billSummaryOriginalFrame;
            [self.arrowImage setImage:[UIImage imageNamed:@"arrow-up-white.png"]];
        }];

    }
}

- (void)populateDataInSummaryView
{
    NSArray *placeOrderItems = [[LocalStorage shared] tempPlaceOrderArray];
    __block NSInteger totalPrice = 0;
    __block NSInteger totalGST = 0;
    
    [placeOrderItems enumerateObjectsUsingBlock:^(MCOPlaceOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        totalPrice += obj.itemTotalPrice;
        totalGST += [obj.f_unit_tax integerValue];
    }];
    
    self.subTotal.text = [NSString stringWithFormat:@"USD %.2f",(float)totalPrice];
    self.gst.text = [NSString stringWithFormat:@"USD %.2f",(float)totalGST];
    self.deliveryCharges.text = @"USD 5.00";
    
    self.total.text = [NSString stringWithFormat:@"USD %.2f",(float)totalPrice + (float)totalGST + (float)5];
    [[LocalStorage shared] setTotalPurchasedIncGST:(float)totalPrice + (float)totalGST + (float)5];
}


- (void)requestOrderSummary
{
    [[RequestMgr shared] getOrderSummaryWithCompletionBlock:^(id response)
    {
        NSDictionary *dict = response[@"data"];
        self.deliveryCharges.text = [NSString stringWithFormat:@"USD %.2f",[dict[@"f_total_charges_amount"] floatValue]];
        self.subTotal.text = [NSString stringWithFormat:@"USD %.2f",[dict[@"f_total_amount"] floatValue]];
        self.total.text = [NSString stringWithFormat:@"USD %.2f",[dict[@"f_total_amount_paid"] floatValue]];
        
        [[LocalStorage shared] setTotalPurchasedIncGST:[dict[@"f_total_amount_paid"] floatValue]];
        [[LocalStorage shared] setTotalDeliveryCharges:[dict[@"f_total_charges_amount"] floatValue]];
        [[LocalStorage shared] setSubTotalAmount:[dict[@"f_total_amount"] floatValue]];
        
    } failure:^(NSError *error) {
        [UIAlertView showGenericErrorMessage];
    }];
}
@end
