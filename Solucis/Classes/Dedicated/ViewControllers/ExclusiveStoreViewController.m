//
//  ExclusiveStoreViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "ExclusiveStoreViewController.h"
#import "ExclusiveStoreListTableViewCell.h"
#import "MCOExclusiveStoreModel.h"


static NSString *const ExclusiveStoreListTableViewCellIdentifier = @"ExclusiveStoreListTableViewCellIdentifier";

@interface ExclusiveStoreViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listings;
@end

@implementation ExclusiveStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ExclusiveStoreListTableViewCell class]) bundle:nil] forCellReuseIdentifier:ExclusiveStoreListTableViewCellIdentifier];
    
    [[RequestMgr shared] requestExclusiveStoreListWithCompletionBlock:^(id response) {
        
        self.listings = response;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.listings objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExclusiveStoreListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExclusiveStoreListTableViewCellIdentifier];
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;

    MCOExclusiveStoreModel *model = self.listings[indexPath.section][indexPath.row];
    
    cell.memberCode.text = model.f_distributor_code;
    cell.memberName.text = model.f_distributor_name;
    cell.sponsorCode.text = model.f_sponsor_code;
    cell.mobileNum.text = model.f_mobile1;
    cell.joinedDate.text = model.f_joined_date;
    cell.rank.text = model.f_rank;
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listings.count;
}

#pragma mark - UITableViewHeader

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:248.0/255.0 blue:249.0/255.0 alpha:1.0];
    
    CGFloat margin = 10.0;
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, self.view.frame.size.width - margin, headerView.frame.size.height)];
    textLbl.font = [UIFont boldSystemFontOfSize:15.0];
    [headerView addSubview:textLbl];
    
    textLbl.text = [NSString stringWithFormat:@"%@ %lu",NSLocalizedString(@"esl_level", ""),(long)section];
    return headerView;
}
@end
