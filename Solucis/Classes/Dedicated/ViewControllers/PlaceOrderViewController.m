//
//  PlaceOrderViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "PlaceOrderCell.h"
#import "MCOPlaceOrderModel.h"
#import "MCOMemberInfo.h"
#import "DeliveryInfoViewController.h"
#import <UIImageView+AFNetworking.h>

#define MINIMUM_PURCHASE_REQUIRED 168

static NSString *const PlaceOrderCellIdentifier = @"PlaceOrderCellIdentifier";

@interface PlaceOrderViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;
@property (weak, nonatomic) IBOutlet UITableView *placeOrderTBV;
@property (strong, nonatomic) IBOutlet UIView *summaryView;
@property (weak, nonatomic) IBOutlet UILabel *totalBV;
@property (weak, nonatomic) IBOutlet UILabel *totalPV;
@property (weak, nonatomic) IBOutlet UILabel *netPrice;
@property (weak, nonatomic) IBOutlet UILabel *summaryNetPrice;
@property (weak, nonatomic) IBOutlet UILabel *netPriceLbl;
@property (nonatomic, assign) CGRect summaryOriginalFrame;
@property (nonatomic, assign) NSInteger totalBVEarned;
@property (nonatomic, assign) NSInteger totalPVEarned;
@property (nonatomic, assign) CGFloat totalAmount;
@property (assign) BOOL summaryViewShown;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) NSArray *placeOrderItem;
@property (nonatomic, strong)MCOMemberInfo *memberInfo;

- (IBAction)summaryButtonDidTouchUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *summaryButton;
@property (weak, nonatomic) IBOutlet UILabel *netPrice1;
@property (weak, nonatomic) IBOutlet UILabel *netPrice2;
@property (weak, nonatomic) IBOutlet UILabel *totalBVLoca;
@property (weak, nonatomic) IBOutlet UILabel *totalPVLocal;

@end

@implementation PlaceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.memberInfo = [[LocalStorage shared] memberInfo];
    
    [self.placeOrderTBV registerNib:[UINib nibWithNibName:NSStringFromClass([PlaceOrderCell class]) bundle:nil] forCellReuseIdentifier:PlaceOrderCellIdentifier];
    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.nextPageButton setTitle:NSLocalizedString(@"title_next_button", "") forState:UIControlStateNormal];
    self.nextPageButton.hidden = YES;
    
    {
        [self.summaryButton setTitle:NSLocalizedString(@"rep_title_summary", "") forState:UIControlStateNormal];
        self.messageLabel.text = NSLocalizedString(@"reg_summary_requirement_text", "");
        self.netPriceLbl.text = NSLocalizedString(@"rep_net_price", "");
        self.netPrice1.text = NSLocalizedString(@"rep_net_price", "");
        self.totalBVLoca.text = NSLocalizedString(@"rep_total_bv", "");
        self.totalPVLocal.text = NSLocalizedString(@"rep_total_pv", "");
    }
    [self requestProductList];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.messageLabel.hidden = YES;
    
    if (self.type == DistributorTypeRegistration)
    {
        [self.progressView setPageName:NSLocalizedString(@"reg_check_out_page", "") currentPage:3 totalPage:TOTAL_PAGES_RD];
    }
    else
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_place_order", "") currentPage:2 totalPage:TOTAL_PAGES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.summaryOriginalFrame = self.summaryView.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.summaryViewShown)
    {
        self.summaryViewShown = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.summaryView.frame = self.summaryOriginalFrame;
        }];
        
        self.netPriceLbl.hidden = NO;
        self.netPrice.hidden = NO;
        self.arrowImage.image = [UIImage imageNamed:@"arrow-up-white.png"];
    }
    
}


#pragma mark - Override Method

- (void)navigateToNextPage
{
    NSArray *products = [self constructedProductInsertParams];
    
    [[RequestMgr shared] confirmPlaceOrderWithProducts:products completionBlock:^(id response) {

        DeliveryInfoViewController *controller = [[DeliveryInfoViewController alloc] init];
        
        if (self.type != DistributorTypeRepurchase)
        {
            controller.type = DistributorTypeRegistration;
        }
        
        NSMutableArray *placedOrders = [NSMutableArray arrayWithArray:[[LocalStorage shared] tempPlaceOrderArray]];
        NSMutableArray *orders = [[NSMutableArray alloc] initWithCapacity:self.placeOrderItem.count];
        
        [placedOrders enumerateObjectsUsingBlock:^(MCOPlaceOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if (obj.totalSelectedItem > 0)
            {
                [orders addObject:obj];
            }
        }];

        [[LocalStorage shared] setTempPlaceOrderArray:[NSArray arrayWithArray:orders]];
        [self.navigationController pushViewController:controller animated:YES];

        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.placeOrderItem.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceOrderCellIdentifier];
    
    [cell.addItemButton addTarget:self action:@selector(addButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    [cell.removeItemButton addTarget:self action:@selector(removeButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    MCOPlaceOrderModel *model = self.placeOrderItem[indexPath.row];
    
    cell.itemName.text = model.name;
    cell.unitBV.text = [NSString stringWithFormat:@"%.0f",[model.f_unit_bv floatValue]];
    cell.unitPV.text = [NSString stringWithFormat:@"%.0f",[model.f_unit_pv floatValue]];
    cell.itemPrice.text = model.products_aftax_price;
    cell.itemGST.text = model.f_unit_tax;
    
    if (model.productImage == nil)
    {
        //NSString *imageURL = [model.image stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *imageURL = [model.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [cell.productImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            cell.productImage.image = image;
            model.productImage = image;
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    else
    {
        cell.productImage.image = model.productImage;
    }
    
    
    cell.totalPrice.text = [NSString stringWithFormat:@" %.2f" , (float)model.itemTotalPrice];
    cell.totalItemDescription.text = [NSString stringWithFormat:@"%lu x %@" , (unsigned long)model.totalSelectedItem , model.products_aftax_price];
    
    return cell;
}


#pragma mark - UITableViewDelegate


#pragma mark - UIAction

- (IBAction)summaryButtonDidTouchUp:(id)sender
{
    [self showSummaryView:!self.summaryViewShown];
}

- (void)showSummaryView:(BOOL)show
{
    if (show)
    {
        self.summaryViewShown = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.summaryView.frame = CGRectMake(0, self.summaryView.frame.origin.y - self.summaryView.frame.size.height + 45, self.summaryView.frame.size.width, self.summaryView.frame.size.height);
        }];
        
        self.netPriceLbl.hidden = YES;
        self.netPrice.hidden = YES;
        
        self.messageLabel.hidden = YES;
        
        if (self.type == DistributorTypeRegistration)
        {
            self.messageLabel.hidden = NO;
        }
        else
        {
            self.messageLabel.hidden = YES;
        }
        
        self.arrowImage.image = [UIImage imageNamed:@"arrow-down-white.png"];
    }
    else
    {
        self.summaryViewShown = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.summaryView.frame = self.summaryOriginalFrame;
        }];
        
        self.netPriceLbl.hidden = NO;
        self.netPrice.hidden = NO;
        self.messageLabel.hidden = YES;
        self.arrowImage.image = [UIImage imageNamed:@"arrow-up-white.png"];
    }
    
}


#pragma mark - Method

- (void)requestProductList
{
    
    NSString *subType;
    
    if (self.type == DistributorTypeRegistration)
    {
        subType = @"REG";
    }
    else
    {
        subType = @"REP";
    }
    
    if (self.memberInfo == nil)
    {
        [[RequestMgr shared] requestMemberInfo:nil completionBlock:^(id response)
         {
             self.memberInfo = (MCOMemberInfo *)response;
             [[LocalStorage shared] setMemberInfo:self.memberInfo];

             [[RequestMgr shared] requestProductListMemberInfo:self.memberInfo completionBlock:^(id response)
             {
                 self.placeOrderItem = [[LocalStorage shared] productLists];
                 [self.placeOrderTBV reloadData];
                 
             } failure:^(NSError *error) {
                 
             }];
             
         } failure:^(NSError *error) {
             
         }];
    }
    else
    {
        [[RequestMgr shared] requestProductListMemberInfo:self.memberInfo completionBlock:^(id response)
         {
             self.placeOrderItem = [[LocalStorage shared] productLists];
             [self.placeOrderTBV reloadData];
             
         } failure:^(NSError *error) {
             
         }];
    }
}


- (void)addButtonDidTouch:(id)sender
{
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.placeOrderTBV];
    NSIndexPath *hitIndex = [self.placeOrderTBV indexPathForRowAtPoint:hitPoint];
    
    MCOPlaceOrderModel *model = self.placeOrderItem[hitIndex.row];
    
    NSInteger totalItemSelected = model.totalSelectedItem;
    
    totalItemSelected += 1;
    
    model.totalSelectedItem = totalItemSelected;
    model.itemTotalPrice = [model.products_aftax_price floatValue] * model.totalSelectedItem;
    [self.placeOrderTBV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:hitIndex.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self addCalculationForSummary:model];

    [[LocalStorage shared] setTempPlaceOrderArray:self.placeOrderItem];
    
    [self.placeOrderTBV reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationNone];
    self.nextPageButton.hidden = NO;
}


- (void)removeButtonDidTouch:(id)sender
{
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.placeOrderTBV];
    NSIndexPath *hitIndex = [self.placeOrderTBV indexPathForRowAtPoint:hitPoint];
    
    MCOPlaceOrderModel *model = self.placeOrderItem[hitIndex.row];
    NSInteger totalItemSelected = model.totalSelectedItem;
    
    if (totalItemSelected == 0)
    {
        return;
    }

    totalItemSelected -= 1;

    if (totalItemSelected == 0)
    {
        self.nextPageButton.hidden = YES;
    }

    model.totalSelectedItem = totalItemSelected;
    model.itemTotalPrice = [model.products_aftax_price integerValue] * model.totalSelectedItem;
    [self.placeOrderTBV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:hitIndex.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self minusCalculationForSummary:model];
    
    [[LocalStorage shared] setTempPlaceOrderArray:self.placeOrderItem];
    [self.placeOrderTBV reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)addCalculationForSummary:(MCOPlaceOrderModel *)model
{
    self.totalBVEarned += [model.f_unit_bv integerValue];
    self.totalPVEarned += [model.f_unit_pv integerValue];
    self.totalAmount += [model.products_aftax_price floatValue];
    self.summaryNetPrice.text = [NSString stringWithFormat:@"USD %.2f" , (float)self.totalAmount];
    self.netPrice.text = [NSString stringWithFormat:@"USD %.2f" , (float)self.totalAmount];
    self.totalBV.text = [NSString stringWithFormat:@"%lu",(long)self.totalBVEarned];
    self.totalPV.text = [NSString stringWithFormat:@"%lu",(long)self.totalPVEarned];
    [self eligibleForGP];
}

- (void)minusCalculationForSummary:(MCOPlaceOrderModel *)model
{
    self.totalBVEarned -= [model.f_unit_bv integerValue];
    self.totalPVEarned -= [model.f_unit_pv integerValue];
    
    self.totalAmount -= [model.products_aftax_price integerValue];
    self.summaryNetPrice.text = [NSString stringWithFormat:@"USD %.2f" , (float)self.totalAmount];
    self.netPrice.text = [NSString stringWithFormat:@"USD %.2f" , (float)self.totalAmount];
    self.totalBV.text = [NSString stringWithFormat:@"%lu",(long)self.totalBVEarned];
    self.totalPV.text = [NSString stringWithFormat:@"%lu",(long)self.totalPVEarned];
    [self eligibleForGP];
}


- (void)eligibleForGP
{
    if (self.type == DistributorTypeRegistration)
    {
        if (self.totalAmount >= MINIMUM_PURCHASE_REQUIRED)
        {
            self.nextPageButton.enabled = YES;
            [self.nextPageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            self.nextPageButton.enabled = NO;
            [self.nextPageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}

- (NSArray *)constructedProductInsertParams
{
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithCapacity:self.placeOrderItem.count];
    
    [self.placeOrderItem enumerateObjectsUsingBlock:^(MCOPlaceOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        NSDictionary *product = @{@"f_qty" : [NSString stringWithFormat:@"%lu",(long)obj.totalSelectedItem] , @"f_product_id" : obj.products_id};
        [mutArr addObject:product];
    }];
    
    return [NSArray arrayWithArray:mutArr];
}
@end
