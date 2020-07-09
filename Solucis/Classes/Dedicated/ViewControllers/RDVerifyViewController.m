//
//  RDVerifyViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDVerifyViewController.h"
#import "MemberCell.h"
#import "MemberHeaderView.h"
#import "MCOMemberInfo.h"
#import "MobileSignUpInfo.h"
#import "PlaceOrderViewController.h"

static NSString *const MemberCellIdentifier = @"MemberCellIdentifier";

@interface RDVerifyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;
@property (nonatomic, strong) MemberHeaderView *headerView;
@end

@implementation RDVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberCell class]) bundle:nil] forCellReuseIdentifier:MemberCellIdentifier];
    [self.nextPageButton setTitle:NSLocalizedString(@"title_next_button", "") forState:UIControlStateNormal];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.progressView setPageName:NSLocalizedString(@"reg_verify_page", "") currentPage:2 totalPage:TOTAL_PAGES_RD];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Override Method

- (void)navigateToNextPage
{
    [[RequestMgr shared] confirmMemberInfoWithTempUserID:self.tempUserID completionBlock:^(id response)
    {        
        PlaceOrderViewController *controller = [[PlaceOrderViewController alloc] init];
        controller.type = DistributorTypeRegistration;
        [self.navigationController pushViewController:controller animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[MemberHeaderView alloc] initNib];
    
    if (section == 0)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_network_info_header", "");
    }
    else if (section == 1)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_member_info_header", "");
    }
    else if (section == 2)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_contact_info_header", "");
    }
    else if (section == 3)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_paypal_account_info", "");
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 6;
    }
    else if (section == 2)
    {
        return 1;
    }
    else if (section == 3)
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
            MCOMemberInfo *info = [[LocalStorage shared] memberInfo];
            
            cell.titleLbl.text = NSLocalizedString(@"reg_sponsor_id", "");
            cell.descriptionLbl.text = [NSString stringWithFormat:@"%@ | %@",info.f_code,info.f_name];
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_verify_name", "");
                    cell.descriptionLbl.text = self.signUpInfo.name;
                    break;
                }
                case 1:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_ID_NO", "");
                    cell.descriptionLbl.text = (self.signUpInfo.companyRegistration) ? self.signUpInfo.f_company_idNumber : self.signUpInfo.idNumber;
                    break;
                }
                case 2:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_nationality", "");
                    cell.descriptionLbl.text = self.signUpInfo.nationality;
                    break;
                }
                case 3:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_dob", "");;
                    cell.descriptionLbl.text = self.signUpInfo.dateOfBirth;
                    break;
                }
                case 4:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_language", "");
                    cell.descriptionLbl.text = self.signUpInfo.preferredLanguageDesc;
                    break;
                }
                case 5:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_register_type", "");
                    cell.descriptionLbl.text = self.signUpInfo.registerType;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            cell.titleLbl.text =NSLocalizedString(@"reg_handphone", "");
            cell.descriptionLbl.text = (self.signUpInfo.companyRegistration) ? self.signUpInfo.f_company_mobile : self.signUpInfo.mobile;
            break;
        }
        case 3:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_pp_registered_nationality", "");
                    cell.descriptionLbl.text = self.signUpInfo.paypalNationalityDesc;
                    break;
                }
                case 1:
                {
                    cell.titleLbl.text = NSLocalizedString(@"reg_pp_account_registered", "");
                    cell.descriptionLbl.text = self.signUpInfo.paypalEmail;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
        {
            break;
        }
    }
    
    return cell;
}


@end
