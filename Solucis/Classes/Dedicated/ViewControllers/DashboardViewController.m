//
//  DashboardViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "DashboardViewController.h"
#import "DashboardTableViewCell.h"

static NSString *const DashboardTableViewCellIdentifier = @"DashboardTableViewCellIdentifier";

@interface DashboardViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSDictionary *dict;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[RequestMgr shared] requestLatestBonusWithCompletionBlock:^(id response) {
        
        self.dict = [NSDictionary dictionaryWithDictionary:response];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DashboardTableViewCell class]) bundle:nil] forCellReuseIdentifier:DashboardTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dict.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DashboardTableViewCellIdentifier];
//    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.shadowColor = [UIColor grayColor].CGColor;
    cell.contentView.layer.shadowOpacity = 1.0;
    cell.contentView.layer.shadowOffset = CGSizeMake(5.0, 5.0);

    switch (indexPath.row)
    {
        case 0:
        {
            cell.amount.text = [NSString stringWithFormat:@"%@",self.dict[@"overriding_bonus"]];
            cell.category.text = NSLocalizedString(@"dashboard_total", @"");
            break;
        }
        case 1:
        {
            cell.amount.text = [NSString stringWithFormat:@"%@",self.dict[@"sub_total"]];
            cell.category.text = NSLocalizedString(@"dashboard_retail_profit", @"");
            break;
        }
        case 2:
        {
            cell.amount.text = [NSString stringWithFormat:@"%@",self.dict[@"total_bonus"]];
            cell.category.text = NSLocalizedString(@"dashboard_exclusive_shop_profits", @"");
            break;
        }
        default:
            break;
    }
    
    return cell;
}


@end
