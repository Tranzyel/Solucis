//
//  NewMemberSignUpViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 18-09-03.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "NewMemberSignUpViewController.h"
#import "NewRegisterTeamInfoCell.h"
#import "NewRegisterMemberInfoCell.h"
#import "MemberHeaderView.h"
#import "FTPickerView.h"
#import "MCOCompanyCode.h"
#import "MCOZoneCodeModel.h"
#import "SubmitNewJoinInfo.h"

@class MCOSponsor;

static NSString *const NewRegisterTeamInfoCellIdentifier = @"NewRegisterTeamInfoCellIdentifier";
static NSString *const NewRegisterMemberInfoCellIdentifier = @"NewRegisterMemberInfoCellIdentifier";

@interface NewMemberSignUpViewController () <UITableViewDelegate,UITableViewDataSource,NewRegisterTeamInfoCellDelegate,NewRegisterMemberInfoCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MemberHeaderView *headerView;
@property (nonatomic, assign) NSUInteger selectedCompanyIndex;
@property (nonatomic, assign) NSUInteger selectedNationalityIndex;
@property (nonatomic, assign) NSUInteger selectedMobileZoneIndex;
@property (nonatomic, strong) NSArray *obs;
@property (nonatomic, assign) BOOL haveSponsor;
@property (nonatomic, strong) SubmitNewJoinInfo *info;
@property (nonatomic, strong) NSString *verifyPasswordString;
@property (nonatomic, strong) UITextField *currentTF;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation NewMemberSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewRegisterTeamInfoCell class]) bundle:nil] forCellReuseIdentifier:NewRegisterTeamInfoCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewRegisterMemberInfoCell class]) bundle:nil] forCellReuseIdentifier:NewRegisterMemberInfoCellIdentifier];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.haveSponsor = NO;
    [self requestData];
    
    self.info = [[SubmitNewJoinInfo alloc] init];
    [self showSubmitButton];
}

- (void)requestData
{
    [[RequestMgr shared] requestCompanyCode:^(id response) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [[RequestMgr shared] requestSponsorCode:NO sponsorID:nil completionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [[RequestMgr shared] requestNationalityCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];

    [[RequestMgr shared] requestZoneCodeCompletionBlock:^(id response) {
        [self.tableView reloadData];
    } failure:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerNotification];
    [self showBackButton];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self deregisterNotification];
    
    //                 MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][index];

}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[MemberHeaderView alloc] initNib];
    
    if (section == 0)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"reg_new_team_info_header", "");
    }
    else if (section == 1)
    {
        self.headerView.headerLabel.text = NSLocalizedString(@"rep_member_info_header", "");
    }

    return self.headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 188.0;
            break;
        case 1:
            return 470.0;
            break;
        default:
            break;
    }
    return 100;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self tableView:tableView teamCellForRowAtIndexPath:indexPath];
            break;
        case 1:
            return [self tableView:tableView memberCellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
        return nil;
}

- (NewRegisterTeamInfoCell *)tableView:(UITableView *)tableView teamCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewRegisterTeamInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NewRegisterTeamInfoCellIdentifier];
    
    NSArray *companies = [[LocalStorage shared] companyCode];
    MCOSponsor *sponsor = [[LocalStorage shared] sponsor];
    
    cell.companyCodeLbl.text = companies[self.selectedCompanyIndex];
    cell.sponsorCodeTF.text = sponsor.f_sponsor_code;
    cell.sponsorNameTF.text = sponsor.f_sponsor_name;
    cell.delegate = self;
    self.info.f_sponsor_code = cell.sponsorCodeTF.text;
    if(self.haveSponsor) {
        cell.sponsorCodeTF.userInteractionEnabled = YES;
        cell.sponsorCodeTF.text = @"";
        cell.sponsorNameTF.text = @"";
        cell.sponsorNameTF.enabled = NO;
        
    }else {
        cell.sponsorCodeTF.userInteractionEnabled = NO;
        cell.sponsorNameTF.userInteractionEnabled = NO;
        cell.sponsorNameTF.enabled = YES;
    }
    
    return cell;
}


- (NewRegisterMemberInfoCell *)tableView:(UITableView *)tableView memberCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewRegisterMemberInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NewRegisterMemberInfoCellIdentifier];
    cell.nationalityLbl.text = ([[LocalStorage shared] filteredNationalities].count > 0) ? [[LocalStorage shared] filteredNationalities][self.selectedNationalityIndex] : @"";
    cell.mobileZone.text = ([[LocalStorage shared] filteredZoneCodes].count > 0) ? [[LocalStorage shared] filteredZoneCodes][self.selectedMobileZoneIndex] : @"";
    cell.delegate = self;
    return cell;
}


#pragma mark - NewRegisterTeamInfoCellDelegate

- (void)companyDropDownDidTouchUp:(id)sender cell:(NewRegisterTeamInfoCell *)cell
{
    NSArray *companies = [[LocalStorage shared] companyCode];
    [self showCompanyCodeCodePicker:cell array:companies];
    NSLog(@"Touchhh Delegate");
}

- (void)segmentedControlDidTouchUp:(BOOL)selected cell:(NewRegisterTeamInfoCell *)cell
{
    self.haveSponsor = selected;
    
    if (self.haveSponsor)
    {
        NSLog(@"YES");
        [self.tableView reloadData];
    }
    else
    {
        [[RequestMgr shared] requestSponsorCode:selected sponsorID:nil completionBlock:^(id response) {
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
        NSLog(@"NO");
    }
}

- (void)sponsorDidFinishEditing:(UITextField *)textField cell:(NewRegisterTeamInfoCell *)cell
{
    if (textField == cell.sponsorCodeTF) {
        [[RequestMgr shared] requestSponsorCode:YES sponsorID:textField.text completionBlock:^(id response) {
            
            self.haveSponsor = NO;/*Hacking*/
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
}


#pragma mark - NewRegisterMemberInfoCellDelegate

- (void)memberInfoDropDownDidTouchUp:(id)sender cell:(NewRegisterMemberInfoCell*)cell
{
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case 0:
        {
            NSArray *array = [[LocalStorage shared] filteredNationalities];
            [self showNationalityPicker:cell array:array];
        }
            break;
        case 1:
        {
            NSArray *array = [[LocalStorage shared] filteredZoneCodes];
            [self showMobileCodePicker:cell array:array];
        }
            break;
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField cell:(NewRegisterMemberInfoCell*)cell
{
    self.currentTF = textField;
    
    if (textField == cell.nameTF) {
        self.info.f_name = textField.text;
    }
    else if (textField == cell.emailTF) {
        self.info.f_email = textField.text;
    }
    else if (textField == cell.passportTF) {
        self.info.f_idno = textField.text;
    }
    else if (textField == cell.mobileNumberTF) {
        self.info.f_mobile = textField.text;
    }
    else if (textField == cell.passwordTF) {
        self.info.f_password = textField.text;
    }
    else if (textField == cell.verifyPasswordTF) {
        self.verifyPasswordString = textField.text;
    }
}


#pragma mark - Private Method

- (void)showCompanyCodeCodePicker:(NewRegisterTeamInfoCell *)cell array:(NSArray *)array
{
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index)
     {
         self.selectedCompanyIndex = index;
         [self.tableView reloadData];
     } cancelBlock:^{
         
     } inIndex:self.selectedCompanyIndex];
}


- (void)showNationalityPicker:(NewRegisterMemberInfoCell *)cell array:(NSArray *)array
{
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index)
     {
         self.selectedNationalityIndex = index;
         [self.tableView reloadData];
     } cancelBlock:^{
         
     } inIndex:self.selectedNationalityIndex];
}


- (void)showMobileCodePicker:(NewRegisterMemberInfoCell *)cell array:(NSArray *)array
{
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:array doneBlock:^(NSInteger index)
     {
         self.selectedMobileZoneIndex = index;
         [self.tableView reloadData];
     } cancelBlock:^{
         
     } inIndex:self.selectedMobileZoneIndex];
}


#pragma mark - UIKeyboardNotification

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

#pragma mark - Private Method
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (void)showSubmitButton
{
    [self.submitButton addTarget:self action:@selector(submitForm) forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButton setTitle:[NSLocalizedString(@"title_submit_button", "") capitalizedString] forState:UIControlStateNormal];
}

- (void)submitForm
{
    [self.currentTF resignFirstResponder];
    
    if ([self checkEmptyField] == TRUE) {
        
        if ([self verifyPassword] == TRUE) {
            
            MCOZoneCodeModel* model = [[LocalStorage shared] zoneCodes][self.selectedMobileZoneIndex];
            self.info.f_mobile_code = model.f_mobile_zone;
            
            [[RequestMgr shared] submitNewJoinForm:self.info completionBlock:^(id response) {
                NSError *error;
                NSDictionary *dict = (NSDictionary *)response;
                
                if (error) {
                    [UIAlertView showGenericErrorMessage];
                }else
                {
                    //Sucess or fail
                    [UIAlertView showErrorWithTitle:@"" message:dict[@"msg"]];
                }
                
            } failure:^(NSError *failure) {
                NSLog(@"Failed Submit : %@",failure);
            }];
        }
        return;
    }
    NSLog(@"Something is wrong");
}

- (BOOL)verifyPassword
{
    if ([self.verifyPasswordString isEqualToString:self.info.f_password]) {
        return YES;
    }
    [UIAlertView showPasswordNotMatched];
    return NO;
}

- (BOOL)checkEmptyField
{
    if (self.info.f_name.length == 0 ||
        self.info.f_email.length == 0 ||
        self.info.f_idno.length == 0 ||
        self.info.f_mobile.length == 0 ||
        self.info.f_password.length == 0 ||
        self.verifyPasswordString.length == 0) {
        
        [UIAlertView showFieldsCannotBeEmptyMessage];
        
        return NO;
    }
    return YES;
}

@end
