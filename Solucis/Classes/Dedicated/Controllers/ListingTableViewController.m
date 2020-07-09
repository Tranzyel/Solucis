//
//  SalesViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "ListingTableViewController.h"

@interface ListingTableViewController ()

@end

@implementation ListingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *calenderButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn-calendar.png"]];
    
    UIView *rightBarButtonView = [[UIView alloc] initWithFrame:calenderButtonImage.frame];
    
    UIButton *calenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    calenderButton.frame = rightBarButtonView.frame;
    [calenderButton setBackgroundImage:calenderButtonImage.image forState:UIControlStateNormal];
    [calenderButton addTarget:self action:@selector(calenderButtonDidTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBarButtonView addSubview:calenderButton];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonView];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calenderButtonDidTouchUp:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionToday = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_today", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self refreshDataForDateRange:TodayDateRangeType];
    }];
    
    UIAlertAction *actionYesterday = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_yesterday", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:YesterdayDateRangeType];
    }];

    UIAlertAction *actionLast7Days = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_last_7_days", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:Last7DaysDateRangeType];
    }];
    
    UIAlertAction *actionLast30Days = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_last_30_days", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:Last30DaysDateRangeType];
    }];

    UIAlertAction *actionThisMonth = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_this_month", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:ThisMonthDateRangeType];
    }];
    
    UIAlertAction *actionLastMonth = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_last_month", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:LastMonthDateRangeType];
    }];

    UIAlertAction *actionAllTime = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_filter_all_time", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:AllTimeDateRangeType];
    }];

    /*
    UIAlertAction *actionCustomRange = [UIAlertAction actionWithTitle:@"Custom Range" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshDataForDateRange:TodayDateRangeType];
    }];
     */
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"date_cancel", "") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alertController addAction:actionToday];
    [alertController addAction:actionYesterday];
    [alertController addAction:actionLast7Days];
    [alertController addAction:actionLast30Days];
    [alertController addAction:actionThisMonth];
    [alertController addAction:actionLastMonth];
    [alertController addAction:actionAllTime];
    //[alertController addAction:actionCustomRange];
    [alertController addAction:actionCancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)refreshDataForDateRange:(DateRange)range
{
    // Override method
}
@end
