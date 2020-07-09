//
//  SalesHistoryViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "SalesHistoryViewController.h"
#import "NSDate+DateRange.h"
#import "AllSalesHistoryTableViewCell.h"
#import "PersonalSalesHistoryTableViewCell.h"
#import "BonusSummaryTableViewCell.h"
#import "MCOPersonalSalesSubmissionData.h"
#import "MCOAllSalesSubmissionModel.h"
#import "MCOBonusSummaryModel.h"

static NSString *const AllSalesHistoryTableViewCellIdentifier = @"AllSalesHistoryTableViewCellIdentifier";
static NSString *const PersonalSalesHistoryTableViewCellIdentifier = @"PersonalSalesHistoryTableViewCellIdentifier";
static NSString *const BonusSummaryTableViewCellIdentifier = @"BonusSummaryTableViewCellIdentifier";

@interface SalesHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *salesList;
@end

@implementation SalesHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AllSalesHistoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:AllSalesHistoryTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PersonalSalesHistoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PersonalSalesHistoryTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BonusSummaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:BonusSummaryTableViewCellIdentifier];
    
    NSString *dateFrom , *dateTo;
    [NSDate dateFromRange:AllTimeDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
    [self requestSalesFromDate:dateFrom toDate:dateTo];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.salesType == SalesBonusType)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.salesType == PersonalSalesHistoryType)
    {
        return 360.0f;
    }
    else if (self.salesType == AllSalesHistoryType)
    {
        return 300.0f;
    }
    else if (self.salesType == SalesBonusType)
    {
        return 195.0f;
    }
    
    return 44.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.salesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.salesType == PersonalSalesHistoryType)
    {
        return [self tableView:tableView personalSalesHistoryTableViewCellForRowAtIndexPath:indexPath];
    }
    else if (self.salesType == AllSalesHistoryType)
    {
        return [self tableView:tableView allSalesHistoryTableViewCellForRowAtIndexPath:indexPath];
    }
    else if (self.salesType == SalesBonusType)
    {
        return [self tableView:tableView bonusSummaryTableViewCellForRowAtIndexPath:indexPath];
    }

    
    return nil;
}

#pragma mark - Cells

- (AllSalesHistoryTableViewCell *)tableView:(UITableView *)tableView allSalesHistoryTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllSalesHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AllSalesHistoryTableViewCellIdentifier];
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;
    /*
     cell.contentView.layer.shadowOffset = CGSizeMake(0, 5);
     cell.contentView.layer.shadowRadius = 5.0;
     cell.contentView.layer.shadowColor = [UIColor grayColor].CGColor;
     cell.contentView.layer.shadowOpacity = 1.0;
     */

    MCOAllSalesSubmissionModel *model = self.salesList[indexPath.row];
    
    cell.docNo.text = [NSString checkEmptyValue:model.f_doc_no];
    cell.type.text = [NSString checkEmptyValue:model.f_doc_subtype];
    cell.submittedDate.text = [NSString checkEmptyValue:model.f_doc_date];
    cell.pv.text = [NSString checkEmptyValue:model.f_total_pv];
    cell.member.text = [NSString checkEmptyValue:model.f_code];
    
    return cell;
}

- (PersonalSalesHistoryTableViewCell *)tableView:(UITableView *)tableView personalSalesHistoryTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalSalesHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalSalesHistoryTableViewCellIdentifier];
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;

    MCOPersonalSalesSubmissionData *model = self.salesList[indexPath.row];
    
    cell.docNo.text = [NSString checkEmptyValue:model.f_doc_no];
    cell.submittedDate.text = [NSString checkEmptyValue:model.f_doc_date];
    cell.pv.text = [NSString checkEmptyValue:model.f_total_pv];
    cell.sdoNo.text = [NSString checkEmptyValue:model.f_do_no];
    cell.consignmentNo.text = [NSString checkEmptyValue:model.f_consignment];
    cell.consignmentDate.text = [NSString checkEmptyValue:model.f_consignment_date];
    return cell;
}

- (BonusSummaryTableViewCell *)tableView:(UITableView *)tableView bonusSummaryTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BonusSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BonusSummaryTableViewCellIdentifier];
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;

    MCOBonusSummaryModel *model = self.salesList[indexPath.row];
    
    cell.exclusiveProfit.text = model.exclusiveProfit;
    cell.date.text = model.date;
    cell.retailProfit.text = model.retailProfit;
    cell.total.text = model.totalBonus;
    
    return cell;
}

#pragma mark - Method

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
}


- (void)requestSalesFromDate:(NSString *)fromDate toDate:(NSString *)toDate
{
    if (self.salesType == PersonalSalesHistoryType)
    {
        [[RequestMgr shared] requestPersonalSalesSubmissionFromDate:fromDate toDate:toDate completionBlock:^(id response) {
            
            self.salesList = [[LocalStorage shared] personalSalesSubmissions];
            [self reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    else if (self.salesType == AllSalesHistoryType)
    {
        [[RequestMgr shared] requestAllSalesSubmissionFromDate:fromDate toDate:toDate completionBlock:^(id response) {
            
            self.salesList = [[LocalStorage shared] allSalesSubmissions];
            [self reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    else if (self.salesType == SalesBonusType)
    {
        [[RequestMgr shared] requestSalesBonusSummaryWithCompletionBlock:^(id response) {
            self.salesList = [[LocalStorage shared] bonusSummaryList];
            [self reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
}


- (void)reloadData
{
    [self.tableView reloadData];
    if (self.salesList.count == 0)
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
