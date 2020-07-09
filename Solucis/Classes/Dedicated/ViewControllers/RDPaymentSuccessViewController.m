//
//  RDPaymentSuccessViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDPaymentSuccessViewController.h"
#import "MemberCell.h"
#import "MemberHeaderView.h"

static NSString *const MemberCellIdentifier = @"MemberCellIdentifier";

@interface RDPaymentSuccessViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MemberHeaderView *headerView;
- (IBAction)doneButtonDidTouchUp:(id)sender;

@end

@implementation RDPaymentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberCell class]) bundle:nil] forCellReuseIdentifier:MemberCellIdentifier];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIAction

- (IBAction)doneButtonDidTouchUp:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(0)];
}


#pragma mark - UITableViewDataSource

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[MemberHeaderView alloc] initNib];
    
    if (section == 0)
    {
        self.headerView.headerLabel.text = @"MEMBER DETAILS";
    }
    else if (section == 1)
    {
        self.headerView.headerLabel.text = @"ACCOUNT INFO";
    }
    
    return self.headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
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
    if (section == 0)
    {
        return 4;
    }
    else if (section == 1)
    {
        return 2;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:MemberCellIdentifier];
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.titleLbl.text = @"MEMBER NAME";
                    cell.descriptionLbl.text = @"-";
                    break;
                }
                case 1:
                {
                    cell.titleLbl.text = @"MEMBER CODE";
                    cell.descriptionLbl.text = @"-";
                    break;
                }
                case 2:
                {
                    cell.titleLbl.text = @"DOC NO";
                    cell.descriptionLbl.text = @"-";
                    break;
                }
                case 3:
                {
                    cell.titleLbl.text = @"DOC TYPE";
                    cell.descriptionLbl.text = @"NEW REGISTRATION";
                    break;
                }
                default:
                    {break;}
            }
                {break;}
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.titleLbl.text = @"SPONSOR CODE";
                    cell.descriptionLbl.text = @"-";
                    break;
                }
                case 1:
                {
                    cell.titleLbl.text = @"SPONSOR NAME";
                    cell.descriptionLbl.text = @"-";
                    break;
                }
                default:
                {break;}
            }
        }
        default:
        {
            break;
        }
    }
    
    return cell;
}


@end
