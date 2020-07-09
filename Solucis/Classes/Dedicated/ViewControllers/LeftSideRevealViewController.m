//
//  LeftSideRevealViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-03-14.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "LeftSideRevealViewController.h"
#import "MemberViewController.h"
#import "MenuViewController.h"
#import "SideRevealViewControllerCell.h"
#import "AnnouncementViewController.h"
#import "DashboardViewController.h"
#import "SalesHistoryViewController.h"
#import "EAccountViewController.h"
#import "RDMemberViewController.h"
#import "AboutUsViewController.h"
#import "ExclusiveStoreViewController.h"
#import "PreLoginViewController.h"
#import "EAccountTransferViewController.h"
#import "ProfileViewController.h"
#import "WithdrawViewController.h"

#define TABLE_BACKGROUND_COLOR [UIColor colorWithRed:49.0/255.0 green:50.0/255.0 blue:51.0/255.0 alpha:1.0]

static NSString * SideRevealViewControllerCellIdentifier = @"SideRevealViewControllerCell";

@interface LeftSideRevealViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *listItems;
@property (nonatomic, strong) NSArray *listIcons;
@end

@implementation LeftSideRevealViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.listIcons = @[[UIImage imageNamed:@"btn-home"],
                       [UIImage imageNamed:@"btn-dashboard-small"],
                       [UIImage imageNamed:@"btn-repurchase-small"],
                       [UIImage imageNamed:@"btn-register-distributor"],
                       [UIImage imageNamed:@"btn-personal-sales"],
                       [UIImage imageNamed:@"btn-sales-history"],
                       [UIImage imageNamed:@"btn-estatement"],
                       [UIImage imageNamed:@"btn-etransfer"],
                       [UIImage imageNamed:@"btn-etransfer"],
                       [UIImage imageNamed:@"btn-sale-bonus"],
                       [UIImage imageNamed:@"btn-distributor-epoint"],
                       [UIImage imageNamed:@"btn-announcement"],
                       [UIImage imageNamed:@"btn-about-us"],
                       [UIImage imageNamed:@"btn-exclusive-store"],
                       [UIImage imageNamed:@"btn-login"],
                       [UIImage imageNamed:@"btn-logout"]];
    
    [self createSideTableView];
    [self.sideTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SideRevealViewControllerCell class]) bundle:nil] forCellReuseIdentifier:SideRevealViewControllerCellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NavigateToNextViewControllerNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSNumber *index = [note object];
        
        if (index >= 0)
        {
            [self nagivateToViewControllerAtIndex:[index integerValue]];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:LanguageDidChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self localizedView];
    }];

    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self localizedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method 

- (void)localizedView
{
    self.listItems = @[NSLocalizedString(@"menu_home_title", ""),
                       NSLocalizedString(@"menu_dashboard_title", ""),
                       NSLocalizedString(@"menu_repurchase_title", ""),
                       NSLocalizedString(@"menu_register_distributor_title", ""),
                       NSLocalizedString(@"menu_personal_sales_history_title", ""),
                       NSLocalizedString(@"menu_all_sales_history_title", ""),
                       NSLocalizedString(@"menu_eAccount_statement_title", ""),
                       NSLocalizedString(@"menu_eAccount_transfer_title", ""),
                       NSLocalizedString(@"menu_withdraw_title", ""),
                       NSLocalizedString(@"menu_sales_bonus_title", ""),
                       NSLocalizedString(@"menu_ePoint_title", ""),
                       NSLocalizedString(@"menu_announcement_title", ""),
                       NSLocalizedString(@"menu_about_us_title", ""),
                       NSLocalizedString(@"menu_exclusive_store_title", ""),
                       NSLocalizedString(@"menu_profile_title", ""),
                       NSLocalizedString(@"menu_log_out_title", "")];
    
    [self.sideTableView reloadData];

}

- (void)createSideTableView
{
    if (self.sideTableView == nil)
    {
        CGRect frame = self.view.bounds;
//        frame.origin.y = 44.0;
//        frame.size.height -= frame.origin.y;
        
        self.sideTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.sideTableView.delegate = self;
        self.sideTableView.dataSource = self;
        self.sideTableView.backgroundColor = TABLE_BACKGROUND_COLOR;
        self.sideTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.sideTableView];
    }
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sideTableView.frame.size.width, 30.0)];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideRevealViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:SideRevealViewControllerCellIdentifier];
    cell.textLbl.text = [self.listItems[indexPath.row] uppercaseString];
    cell.icon.image = self.listIcons[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self nagivateToViewControllerAtIndex:indexPath.row];
}


- (void)nagivateToViewControllerAtIndex:(NSInteger)index
{
    if (index == Repurchase)
    {
        MemberViewController *controller = [[MemberViewController alloc] init];
        controller.type = DistributorTypeRepurchase;
        controller.title = NSLocalizedString(@"nav_bar_repurchase_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == Announcement)
    {
        AnnouncementViewController *controller = [[AnnouncementViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_announcement_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == Home)
    {
        MenuViewController *controller = [[MenuViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_home_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == Dashboard)
    {
        DashboardViewController *controller = [[DashboardViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_dashboard_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == AllSaleHistory)
    {
        [self nagivateToViewControllerAtIndex:Home];
        SalesHistoryViewController *controller = [[SalesHistoryViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_all_sales_title", "");
        controller.salesType = AllSalesHistoryType;
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == PersonalSalesHistory)
    {
        [self nagivateToViewControllerAtIndex:Home];
        SalesHistoryViewController *controller = [[SalesHistoryViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_personal_sales_title", "");
        controller.salesType = PersonalSalesHistoryType;
        [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == SalesBonus)
    {
        [self nagivateToViewControllerAtIndex:Home];
        SalesHistoryViewController *controller = [[SalesHistoryViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_sales_bonus_title", "");
        controller.salesType = SalesBonusType;
        [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == EAccount)
    {
        [self nagivateToViewControllerAtIndex:Home];
        EAccountViewController *controller = [[EAccountViewController alloc] init];
        controller.flowType = EAccountType;
        controller.title = NSLocalizedString(@"nav_bar_statement_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == EPoint)
    {
        [self nagivateToViewControllerAtIndex:Home];
        EAccountViewController *controller = [[EAccountViewController alloc] init];
        controller.flowType = EPointType;
        controller.title = NSLocalizedString(@"nav_bar_ePoint_PV_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == RegisterDistributor)
    {
        RDMemberViewController *controller = [[RDMemberViewController alloc] init];
        controller.type = DistributorTypeRegistration;
        controller.title = NSLocalizedString(@"nav_bar_register_distributor_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == AboutUs)
    {
        AboutUsViewController *controller = [[AboutUsViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_about_us", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == ExclusiveStore)
    {
        ExclusiveStoreViewController *controller = [[ExclusiveStoreViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_exclusive_store_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == EAccountTransfer)
    {
        EAccountTransferViewController *controller = [[EAccountTransferViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_eAccount_transfer_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
    }
    else if (index == Profile)
    {
        ProfileViewController *controller = [[ProfileViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_profile_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
        NSLog(@"Profile Selected");
    }
    else if (index == Withdrawal)
    {
        WithdrawViewController *controller = [[WithdrawViewController alloc] init];
        controller.title = NSLocalizedString(@"nav_bar_withdraw_title", "");
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:controller withSlideOutAnimation:NO andCompletion:nil];
        NSLog(@"Withdrawal Selected");
    }
    else if (index == LogOut)
    {
        PreLoginViewController *loginVC = [[PreLoginViewController alloc] init];
//
//        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:loginVC withSlideOutAnimation:NO andCompletion:^{
//            [[LocalStorage shared] setLoggedIn:NO];
//        }];
        
        [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:loginVC withCompletion:^{
            [[LocalStorage shared] setLoggedIn:NO];
        }];
    }
}


@end

