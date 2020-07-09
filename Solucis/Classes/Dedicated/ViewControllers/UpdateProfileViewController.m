//
//  UpdateProfileViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-22.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import "UpdateProfileMemberCell.h"
#import "RDPayPalAccountInfoTableViewCell.h"
#import "RDAliPayAccountCell.h"
#import "RDBankAccountInfoTableViewCell.h"
#import "UpdateProfileAddressCell.h"
#import "MCOZoneCodeModel.h"

#import "MCOChinaBankList.h"
#import "MCOChinaBankStateList.h"
#import "MCOChinaBankDistrictList.h"

#import "MobileSignUpInfo.h"
#import "MemberHeaderView.h"
#import "FTPickerView.h"
#import "UpdateProfileInfo.h"

#import "MCOPickerView.h"
#import "MCOCountryList.h"
#import "MCOStateList.h"

static NSString *const UpdateProfileMemberCellIdentifier = @"UpdateProfileMemberCellIdentifier";
static NSString *const RDPayPalAccountInfoTableViewCellIdentifier = @"RDPayPalAccountInfoTableViewCellIdentifier";
static NSString *const RDAlipayAccountTableViewCellIdentifier = @"RDAlipayAccountTableViewCellIdentifier";
static NSString *const RDBankAccountInfoTableViewCellIdentifier = @"RDBankAccountInfoTableViewCellIdentifier";
static NSString *const UpdateProfileAddressCellIdentifier = @"UpdateProfileAddressCellIdentifier";

@interface UpdateProfileViewController () <PaypalNationalityDropDownDelegate,AlipayAccountCellDelegate,RDBankAccountInfoTableViewCellDelegate,UpdateProfileMemberCellDelegate,UpdateProfileAddressCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *updateProfileTable;

@property (nonatomic, strong) MobileSignUpInfo *signUpInfo;
@property (nonatomic, strong) UpdateProfileInfo *profileInfo;
@property (nonatomic, strong) MemberHeaderView *headerView;

@property (nonatomic, assign) NSInteger selectedPaypalNationalityIndex;
@property (nonatomic, assign) NSInteger selectedChinaBankIndex;
@property (nonatomic, assign) NSInteger selectedChinaBankStateIndex;
@property (nonatomic, assign) NSInteger selectedChinaBankDistrictIndex;

@property (nonatomic, assign) NSInteger selectedCorrCountryCode;
@property (nonatomic, assign) NSInteger selectedCorrCountry;
@property (nonatomic, assign) NSInteger selectedCorrState;

@property (nonatomic, assign) NSInteger selectedShipCountryCode;
@property (nonatomic, assign) NSInteger selectedShipCountry;
@property (nonatomic, assign) NSInteger selectedShipState;

@property (nonatomic, strong) NSArray *obs;

@property (nonatomic, strong) MCOPickerView *pickerView;
@property (nonatomic, strong) NSString *countryID , *stateID;
@property (nonatomic, strong) NSString *address ,*address2 , *address3 , *address4 , *receiverName , *postCode , *city , *mobilePhone , *country , *state , *mobileZoneCode , *icNo;

@end

@implementation UpdateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.signUpInfo = [[MobileSignUpInfo alloc] init];
    
    [self.updateProfileTable registerNib:[UINib nibWithNibName:NSStringFromClass([UpdateProfileMemberCell class]) bundle:nil] forCellReuseIdentifier:UpdateProfileMemberCellIdentifier];
    [self.updateProfileTable registerNib:[UINib nibWithNibName:NSStringFromClass([RDPayPalAccountInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDPayPalAccountInfoTableViewCellIdentifier];
    [self.updateProfileTable registerNib:[UINib nibWithNibName:NSStringFromClass([RDAliPayAccountCell class]) bundle:nil] forCellReuseIdentifier:RDAlipayAccountTableViewCellIdentifier];
    [self.updateProfileTable registerNib:[UINib nibWithNibName:NSStringFromClass([RDBankAccountInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDBankAccountInfoTableViewCellIdentifier];
    [self.updateProfileTable registerNib:[UINib nibWithNibName:NSStringFromClass([UpdateProfileAddressCell class]) bundle:nil] forCellReuseIdentifier:UpdateProfileAddressCellIdentifier];
    
    [self getData];
    [self showBackButton];
    [self showSubmitButton];
    self.title = NSLocalizedString(@"update_profile_nav_title", "");
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerNotification];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterNotification];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showSubmitButton
{
    UIBarButtonItem *updateProfileItem = [[UIBarButtonItem alloc] initWithTitle:[NSLocalizedString(@"title_submit_button", "") capitalizedString] style:UIBarButtonItemStylePlain target:self action:@selector(updateProfile)];
    updateProfileItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = updateProfileItem;
}


- (void)updateProfile
{
    /*
    [[LocalStorage shared] updateProfile:self.signUpInfo completionBlock:^(id response) {
    } failure:^(NSError *failure) {
        
    }];
    */
    
    [[RequestMgr shared] updateUserProfile:self.signUpInfo
                             completionBlock:^(id response) {
        NSLog(@"Response Update Profile: %@",response);
                                 [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *failure) {
        
    }];
}


- (void)getData
{
    [[RequestMgr shared] requestCountryListCodeWithCompletionBlock:^(id response)
     {
         __block NSString *countryCorrShortName = @"";
         __block NSString *countryShipShortName = @"";
         
         NSArray *countryList = [[LocalStorage shared] countryLists];
         
         [countryList enumerateObjectsUsingBlock:^(MCOCountryList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
             if ([obj.f_id isEqualToString:self.info.f_corr_country]) {
                 self.selectedCorrCountry = idx;
                 countryCorrShortName = obj.f_code;
             }
             
             if ([obj.f_id isEqualToString:self.info.f_ship_country]) {
                 self.selectedShipCountry = idx;
                 countryShipShortName = obj.f_code;
             }
             [self.updateProfileTable reloadData];
         }];
         
         if ([countryCorrShortName length] == 0) {
             countryCorrShortName = @"CN";
         }else if ([countryShipShortName length] == 0) {
             countryShipShortName = @"CN";
         }
         NSLog(@"Corr Short Name : %@" , countryCorrShortName);
         NSLog(@"Ship Short Name : %@" , countryShipShortName);
         
         [[RequestMgr shared] requestStateListCode:countryCorrShortName completionBlock:^(id response)
          {
              NSArray *dataArray = response[@"data"];
              NSMutableArray *stateList = [[RequestMgr shared] parseData:dataArray forClass:[MCOCorrStateList class]];
              
              [[LocalStorage shared] setCorrStateLists:[NSArray arrayWithArray:stateList]];
              
              [stateList enumerateObjectsUsingBlock:^(MCOStateList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                  if ([obj.f_id isEqualToString:self.info.f_corr_state]) {
                      self.selectedCorrState = idx;
                      [self.updateProfileTable reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
                      *stop = YES;
                  }
              }];
              
          } failure:^(NSError *error) {
              
          }];
         
         [[RequestMgr shared] requestStateListCode:countryShipShortName completionBlock:^(id response)
          {
              NSArray *dataArray = response[@"data"];
              NSMutableArray *stateList = [[RequestMgr shared] parseData:dataArray forClass:[MCOShipStateList class]];
              
              [[LocalStorage shared] setShipStateLists:[NSArray arrayWithArray:stateList]];
              
              [stateList enumerateObjectsUsingBlock:^(MCOStateList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                  if ([obj.f_id isEqualToString:self.info.f_ship_state]) {
                      self.selectedShipState = idx;
                      [self.updateProfileTable reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
                      *stop = YES;
                  }
              }];
              
          } failure:^(NSError *error) {
              
          }];

         
         
     } failure:^(NSError *error) {
         
     }];

    
    [[RequestMgr shared] requestZoneCodeCompletionBlock:^(id response) {
        
        NSArray *zoneCodes = [[LocalStorage shared] zoneCodes];
        
        [zoneCodes enumerateObjectsUsingBlock:^(MCOZoneCodeModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.f_mobile_zone isEqualToString:self.info.f_corr_mobile_code]) {
                self.selectedCorrCountryCode = idx;
            }
            
            if ([obj.f_mobile_zone isEqualToString:self.info.f_ship_mobile_code]) {
                self.selectedShipCountryCode = idx;
            }
            
            if ([obj.f_code isEqualToString:self.info.f_paypal_nationality]) {
                self.selectedPaypalNationalityIndex = idx;
            }

        }];
        
        [self.updateProfileTable reloadData];
    } failure:nil];

    
    [[RequestMgr shared] requestChinaBankListCompletionBlock:^(id response) {
        
        NSArray *chinaBankList = [[LocalStorage shared] chinaBankLists];
        
        [chinaBankList enumerateObjectsUsingBlock:^(MCOChinaBankList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.f_id isEqualToString:self.info.f_bank_id]) {
                self.selectedChinaBankIndex = idx;
                *stop = YES;
            }
        }];
        
        [self.updateProfileTable reloadData];
    } failure:nil];
    
    
    [[RequestMgr shared] requestChinaBankStateListCompletionBlock:^(id response) {
        
        NSArray *stateList = [[LocalStorage shared] chinaBankStateLists];
        [stateList enumerateObjectsUsingBlock:^(MCOChinaBankStateList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.f_id isEqualToString:self.info.f_bank_state]) {
                self.selectedChinaBankStateIndex = idx;
                [self.updateProfileTable reloadData];
                *stop = YES;
            }
        }];
        
        MCOChinaBankStateList *list = (MCOChinaBankStateList*)[[LocalStorage shared] chinaBankStateLists][self.selectedChinaBankStateIndex];
        
        [[RequestMgr shared] requestChinaBankDistrictListCompletionBlock:list.f_id response:^(id response) {
            NSArray *districtList = [[LocalStorage shared] chinaBankDistrictLists];

            [districtList enumerateObjectsUsingBlock:^(MCOChinaBankDistrictList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.f_id isEqualToString:self.info.f_bank_city])
                {
                    self.selectedChinaBankDistrictIndex = idx;
                    [self.updateProfileTable reloadData];
                    *stop = YES;
                }
            }];
            
        } failure:nil];
        
    } failure:nil];

}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

#pragma mark - UITableViewDataSource

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[MemberHeaderView alloc] initNib];
    
    if (section == 0)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_member_info_header", "");
    }
    else if (section == 1)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_paypal_account_info", "");
    }
    else if (section == 2)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_alipay_account_info_header", "");
    }
    else if (section == 3)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_bank_account_info_headear", "");
    }
    else if (section == 4)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"update_profile_correspondence_address", "");
    }
    else if (section == 5)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"update_profile_shipping_address", "");
    }
    
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 241.0;
        }
            break;
        case 1:
        {
            return 203.0;
        }
            break;
        case 2:
        {
            return 144.0;
        }
            break;
        case 3:
        {
            return 443.0;
        }
            break;
        case 4:
        {
            return 677.0;
        }
            break;
        case 5:
        {
            return 677.0;
        }
            break;
        default:
            break;
    }
    return 44.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [self tableView:tableView updateProfileMemberCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        return [self tableView:tableView rDPayPalAccountInfoTableViewCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 2)
    {
        return [self tableView:tableView rdAlipayAccountCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 3)
    {
        return [self tableView:tableView rdBankAccountCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 4)
    {
        return [self tableView:tableView addressCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 5)
    {
        return [self tableView:tableView addressCellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (UpdateProfileMemberCell *)tableView:(UITableView *)tableView updateProfileMemberCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UpdateProfileMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:UpdateProfileMemberCellIdentifier];
    cell.memberCodeLbl.text = self.info.f_code;
    cell.memberNameLbl.text = self.info.f_name;
    cell.memberIC.text = ([self.signUpInfo.idNumber length] > 0) ? self.signUpInfo.idNumber:self.info.f_idno;
    
    self.signUpInfo.idNumber = cell.memberIC.text;
    
    cell.delegate = self;
    return cell;
}

- (RDPayPalAccountInfoTableViewCell *)tableView:(UITableView *)tableView rDPayPalAccountInfoTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDPayPalAccountInfoTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:RDPayPalAccountInfoTableViewCellIdentifier];
    
    MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][self.selectedPaypalNationalityIndex];
    cell.paypalNationality.text = model.f_description;
    cell.paypalEmailTF.text = ([self.signUpInfo.paypalEmail length]>0)?self.signUpInfo.paypalEmail:self.info.f_paypal_email;
    cell.ppAccName.text = ([self.signUpInfo.paypalAccountName length]>0)?self.signUpInfo.paypalAccountName:self.info.f_bank_paypal_name;
    
    self.signUpInfo.paypalNationalityDesc = model.f_description;
    self.signUpInfo.paypalNationality = model.f_code;
    self.signUpInfo.paypalEmail = cell.paypalEmailTF.text;
    self.signUpInfo.paypalAccountName = cell.ppAccName.text;
    
    cell.delegate = self;
    return cell;
}


- (RDAliPayAccountCell *)tableView:(UITableView *)tableView rdAlipayAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDAliPayAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:RDAlipayAccountTableViewCellIdentifier];
    cell.alipayAccNoTF.text = ([self.signUpInfo.alipayAccountNumber length]>0)?self.signUpInfo.alipayAccountNumber:self.info.f_bank_alipay_no;
    cell.alipayAccNameTF.text = ([self.signUpInfo.alipayAccountName length]>0)?self.signUpInfo.alipayAccountName:self.info.f_bank_alipay_name;
    
    self.signUpInfo.alipayAccountNumber = cell.alipayAccNoTF.text;
    self.signUpInfo.alipayAccountName = cell.alipayAccNameTF.text;
    cell.delegate = self;
    return cell;
}


- (RDBankAccountInfoTableViewCell*)tableView:(UITableView *)tableView rdBankAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDBankAccountInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RDBankAccountInfoTableViewCellIdentifier];
    
    cell.chinaBankLbl.text = ([[LocalStorage shared] filteredChinaBankLists].count > 0) ? [[LocalStorage shared] filteredChinaBankLists][self.selectedChinaBankIndex] : @"";
    cell.chinaBankStateLbl.text = ([[LocalStorage shared] filteredChinaBankStateLists].count > 0) ? [[LocalStorage shared] filteredChinaBankStateLists][self.selectedChinaBankStateIndex] : @"";
    cell.chinaBankDistrictLbl.text = ([[LocalStorage shared] filteredChinaBankDistrictLists].count > 0) ? [[LocalStorage shared] filteredChinaBankDistrictLists][self.selectedChinaBankDistrictIndex] : @"";
    
    cell.bankAccNameTF.text = ([self.signUpInfo.chinaBankAccountName length]>0)?self.signUpInfo.chinaBankAccountName:self.info.f_bank_account_name;
    cell.bankAccNIRCTF.text = ([self.signUpInfo.chinaBankAccountNIRC length]>0)?self.signUpInfo.chinaBankAccountNIRC:self.info.f_bank_account_owner_ic;
    cell.bankAccNoTF.text = ([self.signUpInfo.chinaBankAccountNumber length]>0)?self.signUpInfo.chinaBankAccountNumber:self.info.f_bank_account_no;
    cell.bankBranch.text = ([self.signUpInfo.chinaBankBranch length]>0)?self.signUpInfo.chinaBankBranch:self.info.f_bank_branch;
    
    MCOChinaBankList *bankList = [[LocalStorage shared] chinaBankLists][self.selectedChinaBankIndex];
    self.signUpInfo.chinaBank = bankList.f_id;
    
    MCOChinaBankStateList *stateList = [[LocalStorage shared] chinaBankStateLists][self.selectedChinaBankStateIndex];
    self.signUpInfo.chinaBankState = stateList.f_id;
    
    MCOChinaBankDistrictList *districtList = [[LocalStorage shared] chinaBankDistrictLists][self.selectedChinaBankDistrictIndex];
    self.signUpInfo.chinaBankDistrict = districtList.f_id;
    
    self.signUpInfo.chinaBankAccountName = cell.bankAccNameTF.text;
    self.signUpInfo.chinaBankAccountNIRC = cell.bankAccNIRCTF.text;
    self.signUpInfo.chinaBankAccountNumber = cell.bankAccNoTF.text;
    self.signUpInfo.chinaBankBranch = cell.bankBranch.text;
    
    cell.delegate = self;
    return cell;
}


- (UpdateProfileAddressCell *)tableView:(UITableView *)tableView addressCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UpdateProfileAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:UpdateProfileAddressCellIdentifier];
    cell.delegate = self;
    
    if (indexPath.section == 4) {
        
        MCOCountryList *countryModel = [[LocalStorage shared] countryLists][self.selectedCorrCountry];
        
        MCOStateList *stateModel = [[LocalStorage shared] corrStateLists][self.selectedCorrState];
        
        MCOZoneCodeModel *zoneCode = [[LocalStorage shared] zoneCodes][self.selectedCorrCountryCode];
        
        cell.address1.text = ([self.signUpInfo.corrAddress1 length]>0)?self.signUpInfo.corrAddress1:self.info.f_corr_address1;
        cell.address2.text = ([self.signUpInfo.corrAddress2 length]>0)?self.signUpInfo.corrAddress2:self.info.f_corr_address2;
        cell.address3.text = ([self.signUpInfo.corrAddress3 length]>0)?self.signUpInfo.corrAddress3:self.info.f_corr_address3;
        cell.address4.text = ([self.signUpInfo.corrAddress4 length]>0)?self.signUpInfo.corrAddress4:self.info.f_corr_address4;
        cell.postCode.text = ([self.signUpInfo.corrPostCode length]>0)?self.signUpInfo.corrPostCode:self.info.f_corr_postcode;
        cell.email.text = ([self.signUpInfo.corrEmail length]>0)?self.signUpInfo.corrEmail:self.info.f_corr_email;
        cell.mobileNumber.text = ([self.signUpInfo.corrMobile length]>0)?self.signUpInfo.corrMobile:self.info.f_corr_mobile1;
        cell.city.text = ([self.signUpInfo.corrCity length]>0)?self.signUpInfo.corrCity:self.info.f_corr_city;
        cell.countryCode.text = zoneCode.f_description;
        cell.country.text = countryModel.f_description; //Macau
        cell.state.text = stateModel.f_description; //Island of Tapa
        cell.mobileCode.text = zoneCode.f_mobile_zone;
        
        self.signUpInfo.corrAddress1 = cell.address1.text;
        self.signUpInfo.corrAddress2 = cell.address2.text;
        self.signUpInfo.corrAddress3 = cell.address3.text;
        self.signUpInfo.corrAddress4 = cell.address4.text;
        self.signUpInfo.corrPostCode = cell.postCode.text;
        self.signUpInfo.corrEmail = cell.email.text;
        self.signUpInfo.corrMobile = cell.mobileNumber.text;
        self.signUpInfo.corrCity = cell.city.text;

        self.signUpInfo.corrCountry = countryModel.f_id;
        self.signUpInfo.corrState = stateModel.f_id;
        
        NSLog(@"Corr Country : %@=%@" , countryModel.f_description,self.signUpInfo.corrCountry);
        NSLog(@"Corr State : %@=%@" , stateModel.f_description,self.signUpInfo.corrState);

        
    }else if (indexPath.section == 5) {
        
        MCOCountryList *countryModel = [[LocalStorage shared] countryLists][self.selectedShipCountry];
        
        MCOStateList *stateModel = [[LocalStorage shared] shipStateLists][self.selectedShipState];
        
        MCOZoneCodeModel *zoneCode = [[LocalStorage shared] zoneCodes][self.selectedShipCountryCode];

        cell.address1.text = ([self.signUpInfo.shipAddress1 length]>0)?self.signUpInfo.shipAddress1:self.info.f_ship_address1;
        cell.address2.text = ([self.signUpInfo.shipAddress2 length]>0)?self.signUpInfo.shipAddress2:self.info.f_ship_address2;
        cell.address3.text = ([self.signUpInfo.shipAddress3 length]>0)?self.signUpInfo.shipAddress3:self.info.f_ship_address3;
        cell.address4.text = ([self.signUpInfo.shipAddress4 length]>0)?self.signUpInfo.shipAddress4:self.info.f_ship_address4;
        cell.postCode.text = ([self.signUpInfo.shipPostCode length]>0)?self.signUpInfo.shipPostCode:self.info.f_ship_postcode;
        cell.email.text = ([self.signUpInfo.shipEmail length]>0)?self.signUpInfo.shipEmail:self.info.f_ship_email;
        cell.mobileNumber.text = ([self.signUpInfo.shipMobile length]>0)?self.signUpInfo.shipMobile:self.info.f_ship_mobile1;
        cell.city.text = ([self.signUpInfo.shipCity length]>0)?self.signUpInfo.shipCity:self.info.f_ship_city;
        cell.state.text = stateModel.f_description;
        cell.country.text = countryModel.f_description;
        cell.countryCode.text = zoneCode.f_description;
        cell.mobileCode.text = zoneCode.f_mobile_zone;
        
        self.signUpInfo.shipAddress1 = cell.address1.text;
        self.signUpInfo.shipAddress2 = cell.address2.text;
        self.signUpInfo.shipAddress3 = cell.address3.text;
        self.signUpInfo.shipAddress4 = cell.address4.text;
        self.signUpInfo.shipPostCode = cell.postCode.text;
        self.signUpInfo.shipEmail = cell.email.text;
        self.signUpInfo.shipMobile = cell.mobileNumber.text;
        self.signUpInfo.shipCity = cell.city.text;
        
        self.signUpInfo.shipCountry = countryModel.f_id;
        self.signUpInfo.shipState = stateModel.f_id;
        //self.signUpInfo.shipBankDistrict = stateModel.f_id;
        NSLog(@"Ship Country : %@=%@" , countryModel.f_description,self.signUpInfo.shipCountry);
        NSLog(@"Ship State : %@=%@" , stateModel.f_description,self.signUpInfo.shipState);
        
    }
    return cell;
}


#pragma mark - PaypalNationalityDropDownDelegate

- (void)paypalNationalityButtonDidTouchUp:(RDPayPalAccountInfoTableViewCell *)cell
{
    [self showPaypalZoneCodePicker:cell array:[[LocalStorage shared] filteredPaypalZoneCodes]];
}

- (void)paypalEmailTextFieldDidFinishedEditing:(NSString *)text
{
    self.signUpInfo.paypalEmail = text;
}

- (void)paypalAccountNameTextFieldDidFinishedEditing:(NSString *)text
{
    self.signUpInfo.paypalAccountName = text;
}


#pragma mark - AlipayAccountCellDelegate

- (void)alipayAccountFieldDidFinishEditing:(NSString *)text fieldType:(AliPayFieldType)type
{
    switch (type) {
        case AlipayAccountNumber:
        {
            self.signUpInfo.alipayAccountNumber = text;
        }
            break;
        case AlipayAccountName:
        {
            self.signUpInfo.alipayAccountName = text;
        }
            break;
        default:
            break;
    }
}


#pragma mark - RDBankAccountInfoTableViewCellDelegate

- (void)bankAccountInfoCellDropDownDidTouchUp:(id)sender
                                         cell:(RDBankAccountInfoTableViewCell *)cell
{
    UIButton *dropdown = (UIButton *)sender;
    
    NSArray *data;
    
    switch (dropdown.tag) {
        case BankInfoPickerChinaBank:
        {
            data = [[LocalStorage shared] filteredChinaBankLists];
            
            if (data.count > 0)
            {
                [self showOptionsPicker:cell array:data bankAccountInfoDropDown:BankInfoChinaBank];
            }
        }
            break;
        case BankInfoPickerChinaState:
        {
            data = [[LocalStorage shared] filteredChinaBankStateLists];
            
            if (data.count > 0)
            {
                [self showOptionsPicker:cell array:data bankAccountInfoDropDown:BankInfoChinaState];
            }
        }
            break;
        case BankInfoPickerChinaDistrict:
        {
            data = [[LocalStorage shared] filteredChinaBankDistrictLists];
            
            if (data.count > 0)
            {
                [self showOptionsPicker:cell array:data bankAccountInfoDropDown:BankInfoChinaDistrict];
            }
        }
            break;
            
        default:
            break;
    }
}


- (void)bankAccountTextFieldDidFinishEditing:(NSString *)text type:(BankAccountFieldType)type
{
    switch (type) {
        case BankAccountName:
        {
            self.signUpInfo.chinaBankAccountName = text;
        }
            break;
        case BankAccountNumber:
        {
            self.signUpInfo.chinaBankAccountNumber = text;
        }
            break;
        case BankAccountNIRC:
        {
            self.signUpInfo.chinaBankAccountNIRC = text;
        }
            break;
        case BankBranch:
        {
            self.signUpInfo.chinaBankBranch = text;
        }
            break;
        default:
            break;
    }
}


#pragma mark - UpdateProfileMemberCellDelegate

- (void)memberICDidFinishEditing:(NSString *)text cell:(UpdateProfileMemberCell *)cell
{
    self.signUpInfo.idNumber = text;
    NSLog(@" Member IC Text : %@" , text);
}


#pragma mark - UpdateProfileAddressCellDelegate

- (void)profileFieldDidFinishEditing:(NSString *)text cell:(UpdateProfileAddressCell *)cell fieldType:(UpdateProfileTextType)type
{
    NSIndexPath *indexPath = [self.updateProfileTable indexPathForCell:cell];
    switch (type) {
        case UpdateAddress1:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrAddress1 = text;
            }
            else
            {
                self.signUpInfo.shipAddress1 = text;
            }
            NSLog(@"Add 1 : %@" , text);
        }
            break;
        case UpdateAddress2:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrAddress2 = text;
            }
            else
            {
                self.signUpInfo.shipAddress2 = text;
            }
            NSLog(@"Add 2 : %@" , text);
        }
            break;
        case UpdateAddress3:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrAddress3 = text;
            }
            else
            {
                self.signUpInfo.shipAddress3 = text;
            }
            NSLog(@"Add 3 : %@" , text);
        }
            break;
        case UpdateAddress4:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrAddress4 = text;
            }
            else
            {
                self.signUpInfo.shipAddress4 = text;
            }
            NSLog(@"Add 4 : %@" , text);
        }
            break;
        case UpdatePostcode:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrPostCode = text;
            }
            else
            {
                self.signUpInfo.shipPostCode = text;
            }
            NSLog(@"Postcode : %@" , text);
        }
            break;
        case UpdateMobileNumber:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrMobile = text;
            }
            else
            {
                self.signUpInfo.shipMobile = text;
            }
            NSLog(@"Mobile : %@" , text);
        }
            break;
        case UpdateEmail:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrEmail = text;
            }
            else
            {
                self.signUpInfo.shipEmail = text;
            }
            NSLog(@"Email : %@" , text);
        }
            break;
        case UpdateCity:
        {
            if (indexPath.section == 4)
            {
                self.signUpInfo.corrCity = text;
            }
            else
            {
                self.signUpInfo.shipCity = text;
            }
            NSLog(@"City : %@" , text);
        }
            break;
            
        default:
            break;
    }
}


- (void)dropDownButtonDidTouchUp:(UpdateProfileDropDownType)type cell:(UpdateProfileAddressCell *)cell
{
    [self.view endEditing:YES];

    NSIndexPath *indexPath = [ self.updateProfileTable indexPathForCell:cell];
    __block NSUInteger selectedIndex;

    switch (type) {
        case UpdateProfileCountryCode:
        {
            NSArray *zoneCodes = [[LocalStorage shared] filteredZoneCodes];
            
            if (indexPath.section == 4) {
                selectedIndex = self.selectedCorrCountryCode;
            }else{
                selectedIndex = self.selectedShipCountryCode;
            }
            
            [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:zoneCodes doneBlock:^(NSInteger index)
             {
                 MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][index];
                 cell.countryCode.text = model.f_description;
                 cell.mobileCode.text = model.f_mobile_zone;
                 
                 if (indexPath.section == 4) {
                     self.selectedCorrCountryCode = index;
                 }else{
                     self.selectedShipCountryCode = index;
                 }
                 
                 [self.updateProfileTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                 
             } cancelBlock:^{
                 
             } inIndex:selectedIndex];
        }
            break;
        case UpdateProfileCountry:
        {
            NSArray *countries = [[LocalStorage shared] filteredCountryList];
            
            if (indexPath.section == 4) {
                selectedIndex = self.selectedCorrCountry;
            }else{
                selectedIndex = self.selectedShipCountry;
            }
            
            [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:countries doneBlock:^(NSInteger index)
             {
                 MCOCountryList *model = [[LocalStorage shared] countryLists][index];
                 cell.country.text = model.f_description;

                 if (indexPath.section == 4) {
                     self.selectedCorrCountry = index;
                 }else{
                     self.selectedShipCountry = index;
                 }
                 [self getStateList:model.f_code inTableSection:indexPath.section];
             } cancelBlock:^{
                 
             } inIndex:selectedIndex];

        }
            break;
        case UpdateProfileState:
        {
            NSArray *countries;
            NSArray *stateLists;
            if (indexPath.section == 4) {
                countries = [[LocalStorage shared] filteredCorrStateList];
                stateLists = [[LocalStorage shared] corrStateLists];
                selectedIndex = self.selectedCorrState;
            }else{
                countries = [[LocalStorage shared] filteredShipStateList];
                stateLists = [[LocalStorage shared] shipStateLists];
                selectedIndex = self.selectedShipState;
            }
            
            [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:countries doneBlock:^(NSInteger index)
             {
                 MCOStateList *model = stateLists[index];
                 cell.state.text = model.f_description;
                 
                 if (indexPath.section == 4) {
                     self.selectedCorrState = index;
                 }else{
                     self.selectedShipState = index;
                 }
                 
                 [self.updateProfileTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
             } cancelBlock:^{
                 
             } inIndex:selectedIndex];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Private Method

- (void)showPaypalZoneCodePicker:(RDPayPalAccountInfoTableViewCell *)cell array:(NSArray *)array
{
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index)
     {
         MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][index];
         cell.paypalNationality.text = model.f_description;
         self.selectedPaypalNationalityIndex = index;
         [self.updateProfileTable reloadData];
     } cancelBlock:^{
         
     } inIndex:self.selectedPaypalNationalityIndex];
}


- (void)showOptionsPicker:(RDBankAccountInfoTableViewCell *)cell
                    array:(NSArray *)array
  bankAccountInfoDropDown:(BankAccountInfoSectionDropDown)dropDownSelection
{
    [self.view endEditing:YES];
    
    NSUInteger currentIndex;
    
    switch (dropDownSelection)
    {
        case BankInfoChinaBank:
        {
            currentIndex = self.selectedChinaBankIndex;
        }
            break;
        case BankInfoChinaState:
        {
            currentIndex = self.selectedChinaBankStateIndex;
        }
            break;
        case BankInfoChinaDistrict:
        {
            currentIndex = self.selectedChinaBankDistrictIndex;
        }
            break;
        default:
        {
            currentIndex = 0;
        }
            break;
    }
    
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index) {
        
        NSString *value = array[index];
        
        switch (dropDownSelection)
        {
            case BankInfoChinaBank:
            {
                self.selectedChinaBankIndex = index;
                cell.chinaBankLbl.text = value;
                [self.updateProfileTable reloadData];
            }
                break;
            case BankInfoChinaState:
            {
                self.selectedChinaBankStateIndex = index;
                cell.chinaBankStateLbl.text = value;
                
                MCOChinaBankStateList *stateList = [[LocalStorage shared] chinaBankStateLists][self.selectedChinaBankStateIndex];
                
                [[RequestMgr shared] requestChinaBankDistrictListCompletionBlock:stateList.f_id response:^(id response) {
                    self.selectedChinaBankDistrictIndex = 0;
                    [self.updateProfileTable reloadData];
                } failure:nil];

            }
                break;
            case BankInfoChinaDistrict:
            {
                self.selectedChinaBankDistrictIndex = index;
                cell.chinaBankDistrictLbl.text = value;
                [self.updateProfileTable reloadData];
            }
                break;
            default:
                break;
        }
        
    } cancelBlock:^{
        
    } inIndex:currentIndex];
}


- (void)registerNotification
{
    id obs1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSDictionary* info = [note userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 20, 0.0);
        self.updateProfileTable.contentInset = contentInsets;
        self.updateProfileTable.scrollIndicatorInsets = contentInsets;
    }];
    
    id obs2 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.updateProfileTable.contentInset = contentInsets;
        self.updateProfileTable.scrollIndicatorInsets = contentInsets;
    }];
    
    self.obs = @[obs1,obs2];
}

- (void)deregisterNotification
{
    [self.obs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }];
}

- (MCOPickerView *)pickerView
{
    if (_pickerView == nil)
    {
        _pickerView = [[MCOPickerView alloc] initWithNib];
        CGRect pickerFrame = _pickerView.frame;
        pickerFrame.origin.y = CGRectGetMaxY(self.view.frame);
        pickerFrame.size.width = self.view.frame.size.width;
        _pickerView.frame = pickerFrame;
        [self.view addSubview:_pickerView];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _pickerView.frame;
            frame.origin.y -= _pickerView.frame.size.height;
            _pickerView.frame = frame;
        }];
    }
    
    return _pickerView;
}

- (void)removePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = _pickerView.frame;
        frame.origin.y += _pickerView.frame.size.height;
        _pickerView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            if (self.pickerView != nil)
            {
                [self.pickerView removeFromSuperview];
                self.pickerView = nil;
            }
        }
        
    }];
}


- (void)getStateList:(NSString *)code inTableSection:(NSUInteger)section
{
    if (code)
    {
        NSArray *countryList = [[LocalStorage shared] countryLists];
        
        [countryList enumerateObjectsUsingBlock:^(MCOCountryList *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.f_code isEqualToString:code])
            {
                self.country = obj.f_description;
                *stop = YES;
            }
        }];
        
        
        [[RequestMgr shared] requestStateListCode:code completionBlock:^(id response)
         {
             NSArray *dataArray = response[@"data"];
             NSMutableArray *stateList;
             
             if (section == 4) {
                 self.selectedCorrState = 0;
                 stateList = [[RequestMgr shared] parseData:dataArray forClass:[MCOCorrStateList class]];
                 [[LocalStorage shared] setCorrStateLists:[NSArray arrayWithArray:stateList]];
             }else if (section == 5) {
                 self.selectedShipState = 0;
                 stateList = [[RequestMgr shared] parseData:dataArray forClass:[MCOShipStateList class]];
                 [[LocalStorage shared] setShipStateLists:[NSArray arrayWithArray:stateList]];
             }
             
             [self.updateProfileTable reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
             
         } failure:^(NSError *error) {
             
         }];
    }
}


@end
