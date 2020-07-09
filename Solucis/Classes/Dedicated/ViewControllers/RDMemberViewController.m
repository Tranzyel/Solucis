//
//  RDMemberViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDMemberViewController.h"
#import "RDMemberInfoTableViewCell.h"
#import "RDContactInfoTableViewCell.h"
#import "RDPayPalAccountInfoTableViewCell.h"
#import "RDTnCAgreementTableViewCell.h"
#import "RDAliPayAccountCell.h"
#import "RDBankAccountInfoTableViewCell.h"
#import "RDDirectorInfo.h"
#import "MemberCell.h"
#import "MemberHeaderView.h"
#import "FTPickerView.h"
#import "MCONationalityModel.h"
#import "MCORegisterTypeModel.h"
#import "MCOLanguageModel.h"
#import "MCOZoneCodeModel.h"
#import "MCOIDTypeModel.h"
#import "MobileSignUpInfo.h"
#import "RDVerifyViewController.h"
#import "MCOMemberInfo.h"
#import "MCOChinaBankList.h"
#import "MCOChinaBankStateList.h"
#import "MCOChinaBankDistrictList.h"

typedef NS_ENUM(NSUInteger , HeaderSection)
{
    NetworkInfoSection,
    MemberInfoSection,
    ContactInfoSection
};

typedef NS_ENUM(NSUInteger , MemberInfoSectionDropDown)
{
    MemberInfoNationality,
    MemberInfoRegisterType,
    MemberInfoDOB,
    MemberInfoLanguage,
    MemberInfoIDType
};


static NSString *const MemberCellIdentifier = @"MemberCellIdentifier";
static NSString *const RDMemberInfoTableViewCellIdentifier = @"RDMemberInfoTableViewCellIdentifier";
static NSString *const RDContactInfoTableViewCellIdentifier = @"RDContactInfoTableViewCellIdentifier";
static NSString *const RDDirectorInfoCellIdentifier = @"RDDirectorInfoCellIdentifier";
static NSString *const RDPayPalAccountInfoTableViewCellIdentifier = @"RDPayPalAccountInfoTableViewCellIdentifier";
static NSString *const RDTnCAgreementTableViewCellIdentifier = @"RDTnCAgreementTableViewCellIdentifier";
static NSString *const RDAlipayAccountTableViewCellIdentifier = @"RDAlipayAccountTableViewCellIdentifier";
static NSString *const RDBankAccountInfoTableViewCellIdentifier = @"RDBankAccountInfoTableViewCellIdentifier";

@interface RDMemberViewController () <RDMemberInfoCellOptionsButtonDidTouchUpDelegate,RDContactInfoTableViewCellCountryCodeButtonDidTouchUpDelegate,RDTermsTableViewCellTnCButtonDidTouchUpDelegate,PaypalNationalityDropDownDelegate,RDDirectorInfoTableCellDelegate,AlipayAccountCellDelegate,RDBankAccountInfoTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MemberHeaderView *headerView;
@property (nonatomic, strong) MobileSignUpInfo *signUpInfo;
@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;
@property (nonatomic , assign) BOOL companyRegistration;
@property (nonatomic , assign) BOOL tnCAccepted;
@property (nonatomic , strong) NSString *dcTempNo;
@property (nonatomic , assign) NSInteger selectedNationalityIndex;
@property (nonatomic , assign) NSInteger selectedRegisterTypeIndex;
@property (nonatomic , assign) NSInteger selectedInfoLanguageIndex;
@property (nonatomic , assign) NSInteger selectedCountryCodeIndex;
@property (nonatomic , assign) NSInteger selectedIDTypeIndex;
@property (nonatomic , assign) NSInteger selectedPaypalNationalityIndex;
@property (nonatomic , assign) NSInteger selectedChinaBankIndex;
@property (nonatomic , assign) NSInteger selectedChinaBankStateIndex;
@property (nonatomic , assign) NSInteger selectedChinaBankDistrictIndex;
@property (nonatomic , strong) NSArray *obs;
@end

@implementation RDMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self requestSalesRequest];
    [self requestMemberInfo];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberCell class]) bundle:nil] forCellReuseIdentifier:MemberCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDMemberInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDMemberInfoTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDContactInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDContactInfoTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDDirectorInfo class]) bundle:nil] forCellReuseIdentifier:RDDirectorInfoCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDPayPalAccountInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDPayPalAccountInfoTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDAliPayAccountCell class]) bundle:nil] forCellReuseIdentifier:RDAlipayAccountTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDBankAccountInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDBankAccountInfoTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDTnCAgreementTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDTnCAgreementTableViewCellIdentifier];

    
    self.signUpInfo = [[MobileSignUpInfo alloc] init];
    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.nextPageButton setTitle:NSLocalizedString(@"title_next_button", "") forState:UIControlStateNormal];
    self.nextPageButton.enabled = NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.progressView setPageName:NSLocalizedString(@"reg_page_member", "") currentPage:1 totalPage:TOTAL_PAGES_RD];
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

#pragma mark - Override Method

- (void)navigateToNextPage
{
    if ([self.signUpInfo.name length] == 0 )
    {
        [UIAlertView showErrorWithTitle:@"" message:NSLocalizedString(@"msg_empty_member_name", "")];
        return;
    }
    
    [self requestMobileSignUp];
}

#pragma mark - Instance Method

- (void)registerNotification
{
    id obs1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSDictionary* info = [note userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 20, 0.0);
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
    }];
    
    id obs2 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
    }];
    
    self.obs = @[obs1,obs2];
}

- (void)deregisterNotification
{
    [self.obs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }];
}

- (void)requestSalesRequest
{
    [[RequestMgr shared] requestSalesRequestWithDocSubtype:DOC_SUB_TYPE_REG completionBlock:^(id response) {
        self.dcTempNo = response;
    } failure:^(NSError *error){}];
    
    [[RequestMgr shared] requestNationalityCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];
    
    [[RequestMgr shared] requestRegisterTypeCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];
    
    [[RequestMgr shared] requestIDTypeCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];
    
    [[RequestMgr shared] requestLanguageCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];
    
    [[RequestMgr shared] requestZoneCodeCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];
    
    [[RequestMgr shared] requestChinaBankListCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];
    
    [[RequestMgr shared] requestChinaBankStateListCompletionBlock:^(id response) {
        
        MCOChinaBankStateList *list = (MCOChinaBankStateList*)[[LocalStorage shared] chinaBankStateLists][0];
        
        [[RequestMgr shared] requestChinaBankDistrictListCompletionBlock:list.f_id response:^(id response) {
            [self.tableView reloadData];
        } failure:nil];
        [self.tableView reloadData];
    } failure:nil];
}


- (void)requestMobileSignUp
{
    [[RequestMgr shared] requestSignUpMemberInfo:self.dcTempNo signUpInfo:self.signUpInfo completionBlock:^(id response)
    {
        NSDictionary *dict = (NSDictionary *)response;
        
        if ([dict[@"status"] integerValue] == 0)
        {
            [UIAlertView showErrorWithTitle:@"" message:dict[@"msg"]];
        }
        else
        {
            NSString *userID = dict[@"f_user_id"];
            RDVerifyViewController *controller = [[RDVerifyViewController alloc] init];
            controller.type = DistributorTypeRegistration;
            controller.signUpInfo = self.signUpInfo;
            controller.tempUserID = userID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    } failure:^(NSError *failure)
     {
         [UIAlertView showGenericErrorMessage];
     }];
    
}


#pragma mark - Picker

- (void)showOptionsPicker:(RDMemberInfoTableViewCell *)cell
                    array:(NSArray *)array
       memberInfoDropDown:(MemberInfoSectionDropDown)dropDownSelection
{
    [self.view endEditing:YES];
    
    NSUInteger currentIndex;
    
    switch (dropDownSelection)
    {
        case MemberInfoNationality:
        {
            currentIndex = self.selectedNationalityIndex;
        }
            break;
        case MemberInfoRegisterType:
        {
            currentIndex = self.selectedRegisterTypeIndex;
        }
            break;
        case MemberInfoLanguage:
        {
            currentIndex = self.selectedInfoLanguageIndex;
        }
            break;
        case MemberInfoIDType:
        {
            currentIndex = self.selectedIDTypeIndex;
        }
            break;
        default:
        {
            currentIndex = self.selectedNationalityIndex;
        }
            break;
    }
    
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index) {
        
        NSString *value = array[index];
        
        switch (dropDownSelection)
        {
            case MemberInfoNationality:
            {
                self.selectedNationalityIndex = index;
                cell.nationality.text = value;
                self.signUpInfo.nationality = value;
            }
                break;
            case MemberInfoRegisterType:
            {
                cell.registerType.text = value;
                self.selectedRegisterTypeIndex = index;
                self.signUpInfo.registerType = value;
                self.companyRegistration = (index > 0) ? YES : NO;
                self.signUpInfo.companyRegistration = self.companyRegistration;
                [self.tableView reloadData];
                
            }
                break;
            case MemberInfoLanguage:
            {
                self.selectedInfoLanguageIndex = index;
                cell.language.text = value;
                [self.tableView reloadData];
            }
                break;
            case MemberInfoIDType:
            {
                self.selectedIDTypeIndex = index;
                cell.idType.text = [value uppercaseString];
                [self.tableView reloadData];
            }
                break;
            default:
                break;
        }
        
    } cancelBlock:^{
        
    } inIndex:currentIndex];
    
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
                [self.tableView reloadData];
            }
                break;
            case BankInfoChinaState:
            {
                self.selectedChinaBankStateIndex = index;
                cell.chinaBankStateLbl.text = value;
                
                MCOChinaBankStateList *stateList = [[LocalStorage shared] chinaBankStateLists][self.selectedChinaBankStateIndex];

                [[RequestMgr shared] requestChinaBankDistrictListCompletionBlock:stateList.f_id response:^(id response) {
                    self.selectedChinaBankDistrictIndex = 0;
                    [self.tableView reloadData];
                } failure:nil];
                
                /*
                [[RequestMgr shared] requestChinaBankStateListCompletionBlock:^(id response) {
                    
                    [[RequestMgr shared] requestChinaBankDistrictListCompletionBlock:stateList.f_id response:^(id response) {
                        self.selectedChinaBankDistrictIndex = 0;
                        [self.tableView reloadData];
                    } failure:nil];
                    [self.tableView reloadData];
                 
                } failure:nil];*/
            }
                break;
            case BankInfoChinaDistrict:
            {
                self.selectedChinaBankDistrictIndex = index;
                cell.chinaBankDistrictLbl.text = value;
                [self.tableView reloadData];
            }
                break;
            default:
                break;
        }
        
    } cancelBlock:^{
        
    } inIndex:currentIndex];
}


- (void)showDatePicker:(RDMemberInfoTableViewCell *)cell
{
    [[FTDatePickerView sharedInstance] showWithTitle:@"" selectDate:nil datePickerMode:UIDatePickerModeDate doneBlock:^(NSDate *selectedDate) {
        
        NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"yyyy-MM-dd"];
        cell.dob.text = [dateFormate stringFromDate:selectedDate];
        self.signUpInfo.dateOfBirth = cell.dob.text;
        
    } cancelBlock:^{
        
    }];
}


- (void)showZoneCodePicker:(RDContactInfoTableViewCell *)cell array:(NSArray *)array
{
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index)
    {
        MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][index];
        cell.countryCode.text = model.zoneCodeWithState;
        cell.mobileCode.text = model.f_mobile_zone;
        self.selectedCountryCodeIndex = index;

        if (self.companyRegistration == YES)
        {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        
    } cancelBlock:^{
        
    } inIndex:self.selectedCountryCodeIndex];
}


- (void)showPaypalZoneCodePicker:(RDPayPalAccountInfoTableViewCell *)cell array:(NSArray *)array
{
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index)
     {
         MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][index];
         cell.paypalNationality.text = model.f_description;
         self.selectedPaypalNationalityIndex = index;
         
     } cancelBlock:^{
         
     } inIndex:self.selectedPaypalNationalityIndex];
}

- (void)requestMemberInfo
{
    [[RequestMgr shared] requestMemberInfo:nil completionBlock:^(id response)
     {
         [[LocalStorage shared] setMemberInfo:response];
         
         [self.tableView reloadData];
         
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
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_director_info_header", "");
    }
    else if (section == 3)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_contact_info_header", "");
    }
    else if (section == 4)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_paypal_account_info", "");
    }
    else if (section == 5)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_alipay_account_info_header", "");
    }
    else if (section == 6)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_bank_account_info_headear", "");
    }
    else if (section == 7)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_terms_and_conditions_header", "");
    }
    
    return self.headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 62.0;
    }
    else if (indexPath.section == 1)
    {
        return 304.0;
    }
    else if (indexPath.section == 2)
    {
        if (!self.companyRegistration)
        {
            return 0;
        }
        return 195.0;
    }
    else if (indexPath.section == 3)
    {
        return 167.0;
    }
    else if (indexPath.section == 4)
    {
        return 203.0;
    }
    else if (indexPath.section == 5)
    {
        return 144.0;
    }
    else if (indexPath.section == 6)
    {
        return 443.0;
    }
    else if (indexPath.section == 7)
    {
        return 142.0;
    }
    
    return 0.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!self.companyRegistration)
    {
        if (section == 2)
        {
            return 0;
        }
    }
    
    return 28;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
       return [self tableView:tableView memberCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        return [self tableView:tableView rdMemberInfoCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 2)
    {
        return [self tableView:tableView rdDirectorInfoCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 3)
    {
        return [self tableView:tableView rdContactInfoCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 4)
    {
        return [self tableView:tableView rDPayPalAccountInfoTableViewCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 5)
    {
        return [self tableView:tableView rdAlipayAccountCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 6)
    {
        return [self tableView:tableView rdBankAccountCellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 7)
    {
        return [self tableView:tableView rDTnCAgreementTableViewCellForRowAtIndexPath:indexPath];
    }

    return nil;
}


#pragma mark - UITableViewCells

- (MemberCell *)tableView:(UITableView *)tableView memberCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:MemberCellIdentifier];

    MCOMemberInfo *info = [[LocalStorage shared] memberInfo];

    switch (indexPath.row)
    {
        case 0:
        {
            cell.titleLbl.text = NSLocalizedString(@"reg_sponsor_id", "");
            cell.descriptionLbl.text = info.f_code;
            break;
        }
        case 1:
        {
            cell.titleLbl.text = NSLocalizedString(@"reg_sponsor_name", "");
            cell.descriptionLbl.text = info.f_name;
            break;
        }
        default:
            {break;}
    }
    
    return cell;
}


- (RDMemberInfoTableViewCell *)tableView:(UITableView *)tableView rdMemberInfoCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDMemberInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RDMemberInfoTableViewCellIdentifier];
    
    cell.nationality.text = ([[LocalStorage shared] filteredNationalities].count > 0) ? [[LocalStorage shared] filteredNationalities][self.selectedNationalityIndex] : @"";
    cell.language.text = ([[LocalStorage shared] filteredLanguages].count > 0) ? [[LocalStorage shared] filteredLanguages][self.selectedInfoLanguageIndex] : @"";
    cell.registerType.text = ([[LocalStorage shared] filteredRegisteredType].count > 0) ? [[LocalStorage shared] filteredRegisteredType][self.selectedRegisterTypeIndex] : @"";
    cell.idType.text = ([[LocalStorage shared] filteredIDTypes].count > 0) ? [[[LocalStorage shared] filteredIDTypes][self.selectedIDTypeIndex] uppercaseString] : @"";

    MCONationalityModel *nationalityModel = [[LocalStorage shared] nationalities][self.selectedNationalityIndex];
    self.signUpInfo.nationality = nationalityModel.f_code;
    
    MCOLanguageModel *languageModel = [[LocalStorage shared] languages][self.selectedInfoLanguageIndex];
    self.signUpInfo.preferredLanguageDesc = languageModel.f_description;
    self.signUpInfo.preferredLanguage = languageModel.f_code;

    MCORegisterTypeModel *registerModel = [[LocalStorage shared] registerTypes][self.selectedRegisterTypeIndex];
    self.signUpInfo.registerType = registerModel.f_code;
    
    MCOIDTypeModel *idTypeModel = [[LocalStorage shared] idTypes][self.selectedIDTypeIndex];
    self.signUpInfo.idType = idTypeModel.f_code;
    
    cell.delegate = self;
    
    return cell;
}


- (RDContactInfoTableViewCell *)tableView:(UITableView *)tableView rdContactInfoCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDContactInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RDContactInfoTableViewCellIdentifier];
    MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][self.selectedCountryCodeIndex];
    cell.countryCode.text = model.zoneCodeWithState;
    cell.mobileCode.text = model.f_mobile_zone;
    
    self.signUpInfo.zoneCode = model.f_zone_code;
    self.signUpInfo.mobileZone = model.f_mobile_zone;
    cell.delegate = self;
    
    return cell;
}


- (RDDirectorInfo *)tableView:(UITableView *)tableView rdDirectorInfoCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDDirectorInfo *cell = [tableView dequeueReusableCellWithIdentifier:RDDirectorInfoCellIdentifier];
    MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][self.selectedCountryCodeIndex];
    
    cell.directorMobileCode.text = (self.companyRegistration) ? model.f_mobile_zone : @"";

    cell.delegate = self;
    return cell;
}


- (RDPayPalAccountInfoTableViewCell *)tableView:(UITableView *)tableView rDPayPalAccountInfoTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDPayPalAccountInfoTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:RDPayPalAccountInfoTableViewCellIdentifier];
    MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][self.selectedPaypalNationalityIndex];
    cell.paypalNationality.text = model.f_description;
    self.signUpInfo.paypalNationalityDesc = model.f_description;
    self.signUpInfo.paypalNationality = model.f_code;
    cell.delegate = self;
    return cell;
}


- (RDAliPayAccountCell *)tableView:(UITableView *)tableView rdAlipayAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDAliPayAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:RDAlipayAccountTableViewCellIdentifier];
    cell.delegate = self;
    return cell;
}


- (RDBankAccountInfoTableViewCell*)tableView:(UITableView *)tableView rdBankAccountCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDBankAccountInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RDBankAccountInfoTableViewCellIdentifier];
    
    cell.chinaBankLbl.text = ([[LocalStorage shared] filteredChinaBankLists].count > 0) ? [[LocalStorage shared] filteredChinaBankLists][self.selectedChinaBankIndex] : @"";
    cell.chinaBankStateLbl.text = ([[LocalStorage shared] filteredChinaBankStateLists].count > 0) ? [[LocalStorage shared] filteredChinaBankStateLists][self.selectedChinaBankStateIndex] : @"";
    cell.chinaBankDistrictLbl.text = ([[LocalStorage shared] filteredChinaBankDistrictLists].count > 0) ? [[LocalStorage shared] filteredChinaBankDistrictLists][self.selectedChinaBankDistrictIndex] : @"";

    
    MCOChinaBankList *bankList = [[LocalStorage shared] chinaBankLists][self.selectedChinaBankIndex];
    self.signUpInfo.chinaBank = bankList.f_id;
    
    MCOChinaBankStateList *stateList = [[LocalStorage shared] chinaBankStateLists][self.selectedChinaBankStateIndex];
    self.signUpInfo.chinaBankState = stateList.f_id;
    
    MCOChinaBankDistrictList *districtList = [[LocalStorage shared] chinaBankDistrictLists][self.selectedChinaBankDistrictIndex];
    self.signUpInfo.chinaBankDistrict = districtList.f_id;
    
    cell.delegate = self;
    return cell;
}


- (RDTnCAgreementTableViewCell *)tableView:(UITableView *)tableView rDTnCAgreementTableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RDTnCAgreementTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:RDTnCAgreementTableViewCellIdentifier];
    cell.delegate = self;
    return cell;
}

#pragma mark - Slide Navigation Controller Delegate

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


#pragma mark - RDBankAccountInfoTableViewCellDelegate

- (void)bankAccountInfoCellDropDownDidTouchUp:(id)sender cell:(RDBankAccountInfoTableViewCell *)cell
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
            NSLog(@"TexT : %@",text);
            self.signUpInfo.chinaBankAccountName = text;
        }
            break;
        case BankAccountNumber:
        {
            NSLog(@"TexT : %@",text);
            self.signUpInfo.chinaBankAccountNumber = text;
        }
            break;
        case BankAccountNIRC:
        {
            NSLog(@"TexT : %@",text);
            self.signUpInfo.chinaBankAccountNIRC = text;
        }
            break;
        case BankBranch:
        {
            self.signUpInfo.chinaBankBranch = text;
            NSLog(@"TexT : %@",text);
        }
            break;
        default:
            break;
    }
}

#pragma mark - RDMemberInfoCellOptionsButtonDidTouchUpDelegate

- (void)memberInfoCellOptionsButtonDidTouchUp:(id)sender cell:(RDMemberInfoTableViewCell *)cell
{
    UIButton *dropdown = (UIButton *)sender;
    
    NSArray *data;
    
    switch (dropdown.tag)
    {
        case MemberInfoNationality:
        {
            data = [[LocalStorage shared] filteredNationalities];
            
            if (data.count > 0)
            {                
                [self showOptionsPicker:cell array:data memberInfoDropDown:MemberInfoNationality];
            }
            
        }
            break;
        case MemberInfoRegisterType:
        {
            data = [[LocalStorage shared] filteredRegisteredType];
            
            if (data.count > 0)
            {
                [self showOptionsPicker:cell array:data memberInfoDropDown:MemberInfoRegisterType];
            }
        }
            break;
        case MemberInfoDOB:
        {
                [self showDatePicker:cell];
        }
            break;
        case MemberInfoLanguage:
        {
            data = [[LocalStorage shared] filteredLanguages];
            
            if (data.count > 0)
            {
                [self showOptionsPicker:cell array:data memberInfoDropDown:MemberInfoLanguage];
            }
        }
            break;
        case MemberInfoIDType:
        {
            data = [[LocalStorage shared] filteredIDTypes];
            
            if (data.count > 0)
            {
                [self showOptionsPicker:cell array:data memberInfoDropDown:MemberInfoIDType];
            }
        }
            break;

        default:
        {}
            break;
    }
}


- (void)memberInfoTextFieldDidFinishedEditing:(NSString *)text textField:(MemberInfoTextField)textField
{
    if (textField == IDTypeTextField)
    {
        self.signUpInfo.idNumber = text;
    }
    else if (textField == MemberNameTextField)
    {
        self.signUpInfo.name = text;
    }
}

#pragma mark - RDTnCAgreementTableViewCellTnCButtonDidTouchUpDelegate

- (void)termsButtonDidTouchUp:(id)sender cell:(RDTnCAgreementTableViewCell *)cell
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    if (button.selected)
    {
        NSLog(@"Button Selected");
        self.tnCAccepted = YES;
        self.nextPageButton.enabled = YES;
    }
    else
    {
        NSLog(@"Button Deselected");
        self.tnCAccepted = NO;
        self.nextPageButton.enabled = NO;
    }
}

#pragma mark - RDContactInfoTableViewCellCountryCodeButtonDidTouchUpDelegate

- (void)countryCodeButtonDidTouchUp:(id)sender cell:(RDContactInfoTableViewCell *)cell
{
    [self showZoneCodePicker:cell array:[[LocalStorage shared] filteredZoneCodes]];
}


- (void)countryCodeMobileTextFieldDidFinishedEditing:(NSString *)text
{
    self.signUpInfo.mobile = text;
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

#pragma mark - RDDirectorInfoTableCellDelegate

- (void)directorInfoTextFieldDidFinishedEditing:(NSString *)text textField:(DirectorInfoTextField)textField
{
    if (textField == DirectorNameTextField)
    {
        self.signUpInfo.f_company_name = text;
    }
    else if (textField == DirectorIDNumberTextField)
    {
        self.signUpInfo.f_company_idNumber = text;
    }
    else if (textField == DirectorMobileNumberTextField)
    {
        self.signUpInfo.f_company_mobile = text;
    }
}

@end
