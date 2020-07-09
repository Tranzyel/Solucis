//
//  ProfileViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-08.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileTableViewCell.h"
#import "RequestMgr.h"
#import "MCOMemberInfo.h"
#import "UpdateProfileViewController.h"

static NSString *const ProfileTableViewCellIdentifier = @"ProfileTableViewCellIdentifier";

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (nonatomic , strong) MCOMemberInfo *info;
@property (nonatomic , strong) NSDateFormatter *formatter;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.profileTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfileTableViewCell class]) bundle:nil] forCellReuseIdentifier:ProfileTableViewCellIdentifier];
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.profileTableView.estimatedRowHeight = 0;
    self.profileTableView.estimatedSectionHeaderHeight = 0;
    self.profileTableView.estimatedSectionFooterHeight = 0;

    [self showUpdateProfileButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [[RequestMgr shared] requestMemberInfo:nil completionBlock:^(id response)
     {
         self.info = (MCOMemberInfo*)response;
         [self.profileTableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showUpdateProfileButton
{
    UIBarButtonItem *updateProfileItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_right_bar_button_item_update", "") style:UIBarButtonItemStylePlain target:self action:@selector(updateProfile)];
    updateProfileItem.tintColor = [UIColor whiteColor];
    
    //[[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]] setTitleTextAttributes:@{NSForegroundColorAttributeName} forState:<#(UIControlState)#>]
    
    self.navigationItem.rightBarButtonItem = updateProfileItem;
}

- (void)updateProfile
{
    UpdateProfileViewController *vc = [[UpdateProfileViewController alloc] init];
    vc.info = self.info;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"Update Profile");
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1500;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileTableViewCellIdentifier];
    
    cell.rankTextLbl.text = self.info.rank_desc;
    cell.memberCodeTextLbl.text = self.info.f_code;
    cell.nameTextLbl.text = self.info.f_name;
    cell.icTextLbl.text = self.info.f_idno;
    cell.joinedDateTextLbl.text = self.info.f_joined_date;
    cell.statusTextLbl.text = ([self.info.f_status isEqualToString:@"A"] ? @"Active":@"Inactive");
    cell.sponsorCodeTextLbl.text = self.info.f_sponsor_code;
    cell.sponsorNameTextLbl.text = self.info.f_sponsor_name;
    
    NSString *address1 = self.info.f_corr_address1;
    NSString *address2 = self.info.f_corr_address2;
    NSString *address3 = self.info.f_corr_address3;
    
    NSMutableString *address = [[NSMutableString alloc] init];
    
    if (address1.length)
    {
        [address appendString:address1];
        [address appendString:@" "];
    }
    if (address2.length)
    {
        [address appendString:address2];
        [address appendString:@" "];
    }
    if (address3.length)
    {
        [address appendString:address3];
    }
    cell.addressTextLbl.text = address;
    
    cell.postCodeTextLbl.text = self.info.f_corr_postcode;
    cell.mobileTextLbl.text = [NSString stringWithFormat:@"%@%@",self.info.f_corr_mobile_code,self.info.f_corr_mobile1];
    cell.telHomeTextLbl.text = self.info.f_corr_tel_h;
    cell.telOfficeTextLbl.text = self.info.f_corr_tel_o;
    cell.faxTextLbl.text = self.info.f_corr_fax;
    cell.emailTextLbl.text = self.info.f_corr_email;
    cell.paypalNationTextLbl.text = self.info.f_paypal_nationality;
    cell.paypalEmailTextLbl.text = self.info.f_paypal_email;
    
    return cell;
}

@end
