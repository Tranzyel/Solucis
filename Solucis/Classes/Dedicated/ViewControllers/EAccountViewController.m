//
//  EAccountViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "EAccountViewController.h"
#import "EAccountStatementTableViewCell.h"
#import "MCOEAccStatementListModel.h"
#import "MCOEpointListModel.h"
#import "NSDate+DateRange.h"

static NSString *const EAccountStatementTableViewCellIdentifier = @"EAccountStatementTableViewCellIdentifier";

@interface EAccountViewController()
@property (weak, nonatomic) IBOutlet UILabel *dateFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateToLabel;
@property (weak, nonatomic) IBOutlet UILabel *eWalletAmountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *singleDateView;
@property (weak, nonatomic) IBOutlet UILabel *singleDateLabel;

@property (nonatomic, strong) NSArray *list;
@end


@implementation EAccountViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EAccountStatementTableViewCell class]) bundle:nil] forCellReuseIdentifier:EAccountStatementTableViewCellIdentifier];
    
    NSString *dateFrom , *dateTo;
    [NSDate dateFromRange:AllTimeDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
    [self requestSalesFromDate:dateFrom toDate:dateTo];

    self.singleDateLabel.text = NSLocalizedString(@"date_filter_all_time", "");

    
    if (self.flowType == EAccountType)
    {
        self.paymentTypeLabel.text = [NSLocalizedString(@"home_eWallet_title", "") uppercaseString];
    }
    else if (self.flowType == EPointType)
    {
        self.paymentTypeLabel.text = [NSLocalizedString(@"home_ePOINT_title", "") uppercaseString];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EAccountStatementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EAccountStatementTableViewCellIdentifier];
    /*
    if (self.flowType == EAccountType)
    {
        
    }
    else if (self.flowType == EPointType)
    {

    }
    */
    
    MCOEpointListModel *model = self.list[indexPath.row];
    
    cell.docNo.text = model.f_doc_no;
    cell.transDate.text = model.f_trans_date;
    cell.inAmt.text = model.f_debit;
    cell.outAmt.text = model.f_credit;
    cell.balance.text = model.f_eacc_bal;
    cell.remark.text = model.f_remark;
    
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;

    return cell;
}

#pragma mark - Override Method

- (void)refreshDataForDateRange:(DateRange)range
{
    NSString *dateFrom , *dateTo;
    
    switch (range)
    {
        case TodayDateRangeType:
        {
            [NSDate dateFromRange:TodayDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        case YesterdayDateRangeType:
        {
            [NSDate dateFromRange:YesterdayDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        case Last7DaysDateRangeType:
        {
            [NSDate dateFromRange:Last7DaysDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        case Last30DaysDateRangeType:
        {
            [NSDate dateFromRange:Last30DaysDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        case ThisMonthDateRangeType:
        {
            [NSDate dateFromRange:ThisMonthDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        case LastMonthDateRangeType:
        {
            [NSDate dateFromRange:LastMonthDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        case AllTimeDateRangeType:
        {
            [NSDate dateFromRange:AllTimeDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
            break;
        }
        default:
        {
            break;
        }
    }
    [self requestSalesFromDate:dateFrom toDate:dateTo];
    [self updateDateRangeUI:dateFrom dateTo:dateTo rangeType:range];
}


#pragma mark - Method

- (void)updateDateRangeUI:(NSString *)dateFrom dateTo:(NSString *)dateTo rangeType:(DateRange)type
{
    switch (type)
    {
        case TodayDateRangeType:
        {
            self.singleDateView.hidden = NO;
            self.singleDateLabel.text = NSLocalizedString(@"date_filter_today", "");
            break;
        }
        case YesterdayDateRangeType:
        {
            self.singleDateView.hidden = NO;
            self.singleDateLabel.text = NSLocalizedString(@"date_filter_yesterday", "");
            break;
        }
        case Last7DaysDateRangeType:
        case Last30DaysDateRangeType:
        case ThisMonthDateRangeType:
        case LastMonthDateRangeType:
        {
            self.singleDateView.hidden = YES;
            break;
        }
        case AllTimeDateRangeType:
        {
            self.singleDateView.hidden = NO;
            self.singleDateLabel.text = NSLocalizedString(@"date_filter_all_time", "");
            break;
        }
        default:
        {
            break;
        }
    }
    
    self.dateFromLabel.text = dateFrom;
    self.dateToLabel.text = dateTo;
}

- (void)requestSalesFromDate:(NSString *)fromDate toDate:(NSString *)toDate
{
    if (self.flowType == EAccountType)
    {
        [[RequestMgr shared] requestEWalletFromDate:fromDate toDate:toDate completionBlock:^(id response) {
            
            self.list = [[LocalStorage shared] eAccStatementLists];
            
            if (self.list.count)
            {
                MCOEAccStatementListModel *model = self.list[0];
                self.eWalletAmountLabel.text = model.ewallet;
            }
            [self reloadData];

            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (self.flowType == EPointType)
    {
        [[RequestMgr shared] requestEpointFromDate:fromDate toDate:toDate completionBlock:^(id response)
        {
            
            self.list = [[LocalStorage shared] ePointLists];
            
            if (self.list.count)
            {
                MCOEpointListModel *model = self.list[0];
                self.eWalletAmountLabel.text = model.epoint;
            }
            [self reloadData];

        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)reloadData
{
    [self.tableView reloadData];
    if (self.list.count == 0)
    {
        [UIAlertView showErrorWithTitle:nil message:NSLocalizedString(@"msg_no_result_found", "")];
    }
}

#pragma mark - LeftSideMenuViewController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
