//
//  EAccountTransferViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-10-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "EAccountTransferViewController.h"
#import "EAccountTransferTableViewCell.h"
#import "MCOEAccStatementListModel.h"
#import "NSDate+DateRange.h"

@interface EAccountTransferViewController () <EAccountTransferDelegate>
@property (weak, nonatomic) IBOutlet UILabel *eAccountValue;
@property (weak, nonatomic) IBOutlet UILabel *eWalletLoc;
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic,strong) NSArray *obs;
@property (nonatomic,strong) NSString *memberID , *memberName , *amount , *remark , *ePin ;
@property (nonatomic, strong) NSString *returnMemberName;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitFormAction:(id)sender;
@end

static NSString *const EAccountTransferTableViewCellIdentifier = @"EAccountTransferTableViewCellIdentifier";

@implementation EAccountTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass([EAccountTransferTableViewCell class]) bundle:nil] forCellReuseIdentifier:EAccountTransferTableViewCellIdentifier];
    [self getWalletAmount];
    
    [self.submitButton setTitle:NSLocalizedString(@"title_submit_button", "") forState:UIControlStateNormal];
    
    self.eWalletLoc.text = NSLocalizedString(@"home_eWallet_title", "");
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

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EAccountTransferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EAccountTransferTableViewCellIdentifier];
    cell.memberNameTF.text = self.returnMemberName;
    [cell.verifyButton addTarget:self action:@selector(verifyNameAction) forControlEvents:UIControlEventTouchUpInside];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - Private Method
- (void)getWalletAmount
{
    NSString *dateFrom , *dateTo;
    [NSDate dateFromRange:AllTimeDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
    [self requestSalesFromDate:dateFrom toDate:dateTo];
}

- (void)requestSalesFromDate:(NSString *)fromDate toDate:(NSString *)toDate
{
    [[RequestMgr shared] requestEWalletFromDate:fromDate toDate:toDate completionBlock:^(id response) {
        
        NSArray *list = [[LocalStorage shared] eAccStatementLists];
        
        if (list.count)
        {
            MCOEAccStatementListModel *model = list[0];
            self.eAccountValue.text = model.ewallet;
        }
        [self.tableV reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];

}

- (void)registerNotification
{
    id obs1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSDictionary* info = [note userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 20, 0.0);
        self.tableV.contentInset = contentInsets;
        self.tableV.scrollIndicatorInsets = contentInsets;
    }];
    
    id obs2 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.tableV.contentInset = contentInsets;
        self.tableV.scrollIndicatorInsets = contentInsets;
    }];
    
    self.obs = @[obs1,obs2];
}


- (void)deregisterNotification
{
    [self.obs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }];
}

- (void)verifyNameAction
{
    //self.memberID = @"8888103358MY";
    
    if ([self.memberID length] == 0 )
    {
        return;
    }
    
    [[RequestMgr shared] verifyMemberNameById:self.memberID completionBlock:^(id response)
    {
        if ([response[@"data"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *data = response[@"data"];
            self.returnMemberName = data[@"f_name"];
            [self.tableV reloadData];
        }
        
    } failure:^(NSError *error)
     {
         [UIAlertView showGenericErrorMessage];
    }];
}

- (void)submitForm
{
    if ([self.memberID length] == 0 || [self.amount length] == 0 || [self.remark length] == 0 || [self.ePin length] == 0)
    {
        [UIAlertView showFieldsCannotBeEmptyMessage];
        return;
    }
    
    [[RequestMgr shared] transferEwalletToMemberID:self.memberID amount:self.amount remarks:self.remark epin:self.ePin completionBlock:^(id response)
    {
        NSDictionary *dict = response;
        
        if ([dict[@"status"] integerValue] == 1)
        {
            [UIAlertView showErrorWithTitle:nil message:dict[@"msg"]];
            [self getWalletAmount];
        }
        else
        {
            [UIAlertView showErrorWithTitle:nil message:dict[@"msg"]];;
        }
        
    } failure:^(NSError *error)
    {
        [UIAlertView showGenericErrorMessage];
    }];
}
    
#pragma mark - EACCOUNT TRANSFER DELEGATE

- (void)eAccountTransferTextFieldDidFinishEditing:(NSString *)text textField:(UITextField *)textField sender:(EAccountTransferTableViewCell *)sender
{
    if (textField.tag == 0)
    {
        self.memberID = text;
    }
    else if (textField.tag == 1)
    {
        //self.memberName = text;
    }
    else if (textField.tag == 2)
    {
        self.amount = text;
    }
    else if (textField.tag == 3)
    {
        self.remark = text;
    }
    else if (textField.tag == 4)
    {
        self.ePin = text;
    }
}

#pragma mark - UIAction

- (IBAction)submitFormAction:(id)sender
{
    [self submitForm];
}
@end
