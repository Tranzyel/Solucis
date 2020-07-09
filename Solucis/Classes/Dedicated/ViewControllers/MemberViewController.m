//
//  MemberViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberCell.h"
#import "MemberHeaderView.h"
#import "MCOMemberInfo.h"
#import "PlaceOrderViewController.h"

static NSString *const MemberCellIdentifier = @"MemberCellIdentifier";

@interface MemberViewController ()
@property ( nonatomic , strong ) MemberHeaderView *headerView;
@property ( nonatomic , strong ) MCOMemberInfo *memberInfo;
@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.nextPageButton setTitle:NSLocalizedString(@"title_next_button", "") forState:UIControlStateNormal];
    [self.memberTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberCell class]) bundle:nil] forCellReuseIdentifier:MemberCellIdentifier];
    
    [[RequestMgr shared] requestMemberInfo:nil completionBlock:^(id response)
    {
        self.memberInfo = (MCOMemberInfo *)response;
        
        [[LocalStorage shared] setMemberInfo:self.memberInfo];
        
        [self.memberTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [[RequestMgr shared] requestSalesRequestWithDocSubtype:DOC_SUB_TYPE_REP completionBlock:nil failure:nil];    
    [[RequestMgr shared] requestZoneCodeCompletionBlock:nil failure:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.progressView setPageName:NSLocalizedString(@"rep_page_member", "") currentPage:1 totalPage:TOTAL_PAGES];
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
        self.headerView.headerLabel.text = NSLocalizedString(@"rep_member_info_header", "");
    else
        self.headerView.headerLabel.text = NSLocalizedString(@"rep_network_info_header", "");
    
    return self.headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
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
            return 3;
        }
        case 1:
        {
            return 2;
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
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:MemberCellIdentifier];
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.titleLbl.text = NSLocalizedString(@"rep_member_id", "");
                    cell.descriptionLbl.text = self.memberInfo.f_code;
                    break;
                }
                case 1:
                {
                    cell.titleLbl.text = NSLocalizedString(@"rep_member_name", "");
                    cell.descriptionLbl.text = self.memberInfo.f_name;
                    break;
                }
                case 2:
                {
                    cell.titleLbl.text = NSLocalizedString(@"rep_rank", "");
                    cell.descriptionLbl.text = self.memberInfo.rank_desc;
                    break;
                }
                default:
                {
                    break;
                }
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.titleLbl.text = NSLocalizedString(@"rep_sponsor_id", "");
                    cell.descriptionLbl.text = self.memberInfo.f_sponsor_code;
                    break;
                }
                case 1:
                {
                    cell.titleLbl.text = NSLocalizedString(@"rep_sponsor_name", "");
                    cell.descriptionLbl.text = self.memberInfo.f_sponsor_name;
                    break;
                }
                default:
                {
                    break;
                }
            }
            break;
        }
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
