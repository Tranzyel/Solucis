//
//  WithdrawViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 18-09-05.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "WithdrawViewController.h"
#import "NSDate+DateRange.h"
#import "MCOEAccStatementListModel.h"
#import "WithdrawalTableViewCell.h"
#import "MemberHeaderView.h"
#import "FTPickerView.h"

static NSString *const WithdrawalTableViewCellIdentifier = @"WithdrawalTableViewCellIdentifier";

@interface WithdrawViewController () <WithdrawalTableViewCellDelegate>
@property (nonatomic, strong) NSArray *list;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *eAccountValue;
@property (weak, nonatomic) IBOutlet UILabel *eWalletLoc;
- (IBAction)submitDidTouchUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) MemberHeaderView *headerView;
@property (nonatomic, strong) NSArray *obs;
@property (nonatomic, strong) NSString *amount, *ePin;
@property (nonatomic, strong) NSArray *withdrawMethods;
@property (nonatomic, assign) NSUInteger selectedWithdrawMethod;
@property (nonatomic, strong) UITextField *currentTextField;
@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WithdrawalTableViewCell class]) bundle:nil] forCellReuseIdentifier:WithdrawalTableViewCellIdentifier];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self requestEwallet];
    [self.submitButton setTitle:NSLocalizedString(@"title_submit_button", "") forState:UIControlStateNormal];
    self.eWalletLoc.text = NSLocalizedString(@"home_eWallet_title", "");
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerNotification];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self deregisterNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestEwallet
{
    NSString *dateFrom , *dateTo;
    [NSDate dateFromRange:AllTimeDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
    
    [self requestSalesFromDate:dateFrom toDate:dateTo];
}

- (void)requestSalesFromDate:(NSString *)fromDate toDate:(NSString *)toDate
{
    [[RequestMgr shared] requestEWalletFromDate:fromDate toDate:toDate completionBlock:^(id response) {
        
        self.list = [[LocalStorage shared] eAccStatementLists];
        
        if (self.list.count)
        {
            MCOEAccStatementListModel *model = self.list[0];
            self.eAccountValue.text = model.ewallet;            
        }
    } failure:^(NSError *error) {
        
    }];
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
        self.headerView.headerLabel.text = NSLocalizedString(@"menu_withdraw_title", "");
    }
    
    return self.headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WithdrawalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WithdrawalTableViewCellIdentifier];
    
    NSDictionary *dict = self.withdrawMethods[self.selectedWithdrawMethod];
    cell.withdrawMethodLbl.text = dict[@"f_description"];
    cell.delegate = self;
    return cell;
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


#pragma mark - WithdrawalTableViewCellDelegate

- (void)withdrawDropDownDidTouchUp:(id)sender cell:(WithdrawalTableViewCell *)cell
{
    [self showWithDrawMethodPicker:cell array:self.withdrawMethods];
}

- (void)textFieldDidEndEditing:(UITextField *)textField cell:(WithdrawalTableViewCell *)cell
{
    self.currentTextField = textField;
    
    if (textField == cell.amountTF) {
        self.amount = textField.text;
        
        [[RequestMgr shared] requestWithdrawMethodWithAmount:self.amount completionBlock:^(id response) {
            
            NSDictionary *dict = (NSDictionary *)response;
            
            if ([dict[@"status"] integerValue] == 1) {
                self.withdrawMethods = response[@"data"];
                [self.tableView reloadData];
            }
            else
            {
                [UIAlertView showErrorWithTitle:@"" message:dict[@"msg"]];
            }
            
        } failure:^(NSError *failure) {
            
        }];
        
    }else if (textField == cell.epinTF) {
        self.ePin = textField.text;
    }
}

#pragma mark - Private Method

- (IBAction)submitDidTouchUp:(id)sender
{
    NSDictionary *dict = self.withdrawMethods[self.selectedWithdrawMethod];
    
    [[RequestMgr shared] submitWithdrawalRequest:self.amount withdrawalMethod:dict[@"f_code"] epin:self.ePin completionBlock:^(id response) {
        
        NSDictionary *dict = (NSDictionary *)response;
        [UIAlertView showErrorWithTitle:@"" message:dict[@"msg"]];
        
        if ([dict[@"status"] integerValue] == 1) {
            [self requestEwallet];
        }
        
    } failure:^(NSError *failure) {
        
    }];
}

- (void)showWithDrawMethodPicker:(WithdrawalTableViewCell *)cell array:(NSArray *)array
{
    
    if ([self.currentTextField isFirstResponder]) {
        [self.currentTextField resignFirstResponder];
    }
    
    NSMutableArray *methods = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [methods addObject:obj[@"f_description"]];
    }];
    
    [[FTPickerView sharedInstance] showWithTitle:@"" nameArray:methods doneBlock:^(NSInteger index)
     {
         self.selectedWithdrawMethod = index;
         [self.tableView reloadData];
     } cancelBlock:^{
         
     } inIndex:self.selectedWithdrawMethod];
}

@end
