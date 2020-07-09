//
//  DeliveryInfoViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-04.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "DeliveryInfoViewController.h"
#import "MCOMemberInfo.h"
#import "MCOPickerView.h"
#import "MCOStateList.h"
#import "MCOCountryList.h"
#import "RDDeliveryTableViewCell.h"
#import "PurchaseInfoViewController.h"
#import "UpdateShippingAddressInfo.h"
#import "MCOShippingAddressModel.h"

static NSString *const DeliveryInfoPickUpTableViewCellIdentifier = @"DeliveryInfoPickUpTableViewCellIdentifier";
static NSString *const DeliveryInfoDeliveryToTableViewCellIdentifier = @"DeliveryInfoDeliveryToTableViewCellIdentifier";
static NSString *const RDDeliveryTableViewCellIdentifier = @"RDDeliveryTableViewCellIdentifier";

@interface DeliveryInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MCOMemberInfo *memberInfo;
@property (nonatomic, assign) BOOL deliveryMethod;
@property (nonatomic, assign) BOOL addressChanged;
@property (nonatomic, strong) MCOPickerView *pickerView;
@property (nonatomic, strong) NSString *address ,*address2 , *address3 , *address4 , *receiverName , *postCode , *city , *mobilePhone , *country , *state , *mobileZoneCode , *icNo;
@property (nonatomic, strong) MCOShippingAddressModel *shippingAddress;
@property (nonatomic, strong) NSString *countryID , *stateID;
@end

@implementation DeliveryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.memberInfo = [[LocalStorage shared] memberInfo];
    self.deliveryMethod = YES;
    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.nextPageButton setTitle:NSLocalizedString(@"title_next_button", "") forState:UIControlStateNormal];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DeliveryInfoDeliveryToTableViewCell class]) bundle:nil] forCellReuseIdentifier:DeliveryInfoDeliveryToTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DeliveryInfoPickUpTableViewCell class]) bundle:nil] forCellReuseIdentifier:DeliveryInfoPickUpTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RDDeliveryTableViewCell class]) bundle:nil] forCellReuseIdentifier:RDDeliveryTableViewCellIdentifier];

    [self registerKeybardNotification];
    
    [[RequestMgr shared] requestCountryListCodeWithCompletionBlock:^(id response)
    {
    } failure:^(NSError *error) {
        
    }];
    
    [self getShippingAddress];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.type == DistributorTypeRepurchase)
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_delivery_info", "") currentPage:3 totalPage:TOTAL_PAGES];
    }
    else if (self.type == DistributorTypeRegistration)
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_delivery_info", "") currentPage:4 totalPage:TOTAL_PAGES_RD];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override Method

- (void)navigateToNextPage
{
    PurchaseInfoViewController *controller = [[PurchaseInfoViewController alloc] init];
    
    if (self.type == DistributorTypeRepurchase)
    {
        if ([self checkRequiredField] == NO)
        {
            [UIAlertView showErrorWithTitle:@"" message:NSLocalizedString(@"msg_empty_fields", "")];
            return;
        }
    }
    else if (self.type == DistributorTypeRegistration)
    {
        if ([self checkRequiredField] == NO)
        {
            [UIAlertView showErrorWithTitle:@"" message:NSLocalizedString(@"msg_empty_fields", "")];
            return;
        }
        
        if (self.type != DistributorTypeRepurchase)
        {
            controller.type = DistributorTypeRegistration;
        }
    }
    
    [[RequestMgr shared] updateShippingAddressWithCompletionBlock:^(id response)
     {
         if ([response[@"status"] integerValue] == 1)
         {
             [self.navigationController pushViewController:controller animated:YES];
         }
         else
         {
             [UIAlertView showErrorWithTitle:nil message:response[@"msg"]];
         }
         
     } failure:^(NSError *error)
     {
         [UIAlertView showGenericErrorMessage];
     }];

}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 660.0f;
    /*
    if (self.type == DistributorTypeRepurchase)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                return 95.0;
            }
            case 1:
            {
                return 450.0f;
            }
            default:
            {
                break;
            }
        }
    }
    else if (self.type == DistributorTypeRegistration)
    {
        return 165.0f;
    }

    return 0.0f;
     */
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    /*
    if (self.type == DistributorTypeRepurchase)
    {
        return 2;
    }
    else if (self.type == DistributorTypeRegistration)
    {
        return 1;
    }
    
    return 0;
     */
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (self.type == DistributorTypeRepurchase)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                DeliveryInfoPickUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeliveryInfoPickUpTableViewCellIdentifier];
                cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                cell.contentView.layer.borderWidth = 1.0f;
                cell.delegate = self;
                
                if (!self.deliveryMethod)
                {
                    cell.radioButton.selected = YES;
                }
                else
                {
                    cell.radioButton.selected = NO;
                }
                
                return cell;
            }
            case 1:
            {
                DeliveryInfoDeliveryToTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeliveryInfoDeliveryToTableViewCellIdentifier];
                cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                cell.contentView.layer.borderWidth = 1.0f;
                
                cell.delegate = self;
                
                if (self.deliveryMethod)
                {
                    cell.radioButton.selected = YES;
                }
                else
                {
                    cell.radioButton.selected = NO;
                }
                
                NSString *address1 = self.memberInfo.f_corr_address1;
                NSString *address2 = self.memberInfo.f_corr_address2;
                NSString *address3 = self.memberInfo.f_corr_address3;
                
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
                
                cell.addressTextField.text = address;
                
                cell.postCodeTextField.text = self.memberInfo.f_corr_postcode;
                cell.mobileTextField.text = [NSString stringWithFormat:@"%@%@",self.memberInfo.f_corr_mobile_code,self.memberInfo.f_corr_mobile1];
                cell.countryLabel.text = self.country;
                cell.stateLabel.text = self.state;
                
                return cell;
            }
            default:
            {
                break;
            }
        }
    }
    else if (self.type == DistributorTypeRegistration)
    {
        RDDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RDDeliveryTableViewCellIdentifier];
        return cell;
    }
     return nil;
    */
    

    DeliveryInfoDeliveryToTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeliveryInfoDeliveryToTableViewCellIdentifier];
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.delegate = self;
    cell.radioButton.selected = (self.deliveryMethod) ? YES : NO;
    
    if (self.type == DistributorTypeRepurchase)
    {
        NSString *address1 = self.shippingAddress.f_address1;
        NSString *address2 = self.shippingAddress.f_address2;
        NSString *address3 = self.shippingAddress.f_address3;
        NSString *address4 = self.shippingAddress.f_address4;

        /*
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
         */
        
        cell.addressTextField.text = address1;
        self.address = cell.addressTextField.text;
        
        cell.address2TextField.text = address2;
        self.address2 = cell.address2TextField.text;

        cell.address3TextField.text = address3;
        self.address3 = cell.address3TextField.text;

        cell.address4TextField.text = address4;
        self.address4 = cell.address4TextField.text;

        cell.icNumberTextField.text = self.shippingAddress.f_idno;
        self.icNo = cell.icNumberTextField.text;
        
        cell.postCodeTextField.text = self.shippingAddress.f_postcode;
        self.postCode = cell.postCodeTextField.text;
        
        cell.mobileTextField.text = self.shippingAddress.f_mobile1;
        self.mobilePhone = cell.mobileTextField.text;
        
        cell.countryLabel.text = (self.addressChanged) ? self.country:self.shippingAddress.f_country;
        self.country = cell.countryLabel.text;
        
        cell.stateLabel.text = (self.addressChanged) ? self.state:self.shippingAddress.f_state;
        self.state = cell.stateLabel.text;
        
        cell.receiverTextField.text = self.shippingAddress.f_contact;
        self.receiverName = self.shippingAddress.f_contact;
        
        cell.cityTextField.text = self.shippingAddress.f_city;
        self.city = cell.cityTextField.text;
        
        cell.countryCode.text = self.shippingAddress.f_mobile_code;
        self.mobileZoneCode = cell.countryCode.text;
    }
    else
    {
        cell.countryLabel.text = self.country;
        self.country = cell.countryLabel.text;

        cell.stateLabel.text = self.state;
        self.state = cell.stateLabel.text;

    }
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - Method

- (void)registerKeybardNotification
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CGSize keyboardSize = [[[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height) + 20, 0.0);
        } else {
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
        }
        
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
        
//        [self.tableView scrollToRowAtIndexPath:self.editingIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {

        NSNumber *rate = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        [UIView animateWithDuration:rate.floatValue animations:^{
            self.tableView.contentInset = UIEdgeInsetsZero;
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
        }];
        
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


- (void)getStateList:(NSString *)code
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
            NSArray *stateList = [[LocalStorage shared] stateLists];
            if (stateList.count)
            {
                MCOStateList *state = stateList[0];
                self.state = state.f_description;
                self.stateID = state.f_id;
                [self.tableView reloadData];
            }
            else
            {
                //self.state = @"";
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
}


- (void)getShippingAddress
{
    [[RequestMgr shared] requestShippingAddressWithCompletionBlock:^(id response) {
        
        self.shippingAddress = (MCOShippingAddressModel *)response;
        self.countryID = self.shippingAddress.country_id;
        self.stateID = self.shippingAddress.state_id;
   
        if ([self.shippingAddress.f_code length] > 0)
        {
            [self getStateList:self.shippingAddress.f_code];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Failure Shipping Address : %@" , error);
    }];
}


- (BOOL)checkRequiredField
{
    if ([self.receiverName length] == 0 || [self.postCode length] == 0 || [self.country length] == 0 || [self.state length] == 0 || [self.mobilePhone length] == 0 || [self.mobileZoneCode length] == 0 || [self.icNo length] == 0)
    {
        return NO;
    }
    
    UpdateShippingAddressInfo *shippingInfo = [[UpdateShippingAddressInfo alloc] init];
    shippingInfo.f_address_1 = [NSString checkEmptyParam:self.address];
    shippingInfo.f_address_2 = [NSString checkEmptyParam:self.address2];
    shippingInfo.f_address_3 = [NSString checkEmptyParam:self.address3];
    shippingInfo.f_address_4 = [NSString checkEmptyParam:self.address4];
    shippingInfo.f_contact = [NSString checkEmptyParam:self.receiverName];
    shippingInfo.f_postcode = [NSString checkEmptyParam:self.postCode];
    shippingInfo.f_country = [NSString checkEmptyParam:self.countryID];
    shippingInfo.f_state = [NSString checkEmptyParam:self.stateID];
    shippingInfo.f_city = [NSString checkEmptyParam:self.city];
    shippingInfo.mobileNumber1 = [NSString stringWithFormat:@"%@",self.mobilePhone];
    shippingInfo.mobileCode = self.mobileZoneCode;
    shippingInfo.icNumber = [NSString checkEmptyParam:self.icNo];
    
    [[LocalStorage shared] setShippingInfo:shippingInfo];
    
    return YES;
}

#pragma mark - DeliveryInfoDeliveryToDelegate

- (void)deliveryInfoDeliveryToRadioButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender
{
    self.deliveryMethod = YES;
    [self.tableView reloadData];
}

- (void)deliveryInfoCountryButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender
{
    [self.pickerView showPickerViewWithType:PickerTypeCountry withCompletion:^(NSString *code, NSString *description, NSString *countryCode, NSString *identityCode)
    {
        self.addressChanged = YES;
        self.countryID = identityCode;
        [self getStateList:code];
        [self.tableView reloadData];
        [self removePickerView];
 
    } cancelBlock:^{
        [self removePickerView];
    }];
}

- (void)deliveryInfoStateButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender
{
    [self.pickerView showPickerViewWithType:PickerTypeState withCompletion:^(NSString *code, NSString *description, NSString *countryCode, NSString *identityCode) {
        self.addressChanged = YES;
        self.stateID = identityCode;
        self.state = description;
        [self.tableView reloadData];
        [self removePickerView];
        
    } cancelBlock:^{
        [self removePickerView];
    }];
    
}

- (void)deliveryInfoMobileCountryCodeButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender
{
    
    [self.pickerView showPickerViewWithType:PickerTypeMobileCountryCode withCompletion:^(NSString *code , NSString *description , NSString *mobileCountryCode, NSString *dentityCode)
    {
        sender.countryCode.text = mobileCountryCode;
        self.mobileZoneCode = ([code length] > 0) ? code : mobileCountryCode;
        [self removePickerView];
    
    } cancelBlock:^{
        [self removePickerView];
    }];
    
}

- (void)deliveryInfoTextFieldDidFinishedEditing:(DeliveryInfoDeliveryToTableViewCell *)sender text:(UITextField *)textField
{
    NSString *value = textField.text;
    
    if (textField.tag == DeliveryInfoAddress)
    {
        self.address = value;
    }
    else if (textField.tag == DeliveryInfoReceiverName)
    {
        self.receiverName = value;
    }
    else if (textField.tag == DeliveryInfoPostCode)
    {
        self.postCode = value;
    }
    else if (textField.tag == DeliveryInfoCity)
    {
        self.city = value;
    }
    else if (textField.tag == DeliveryInfoMobilePhone)
    {
        self.mobilePhone = value;
    }
    else if (textField.tag == DeliveryInfoAddress2)
    {
        self.address2 = value;
    }
    else if (textField.tag == DeliveryInfoAddress3)
    {
        self.address3 = value;
    }
    else if (textField.tag == DeliveryInfoAddress4)
    {
        self.address4 = value;
    }
    else if (textField.tag == DeliveryICNumber)
    {
        self.icNo = value;
    }
}


#pragma mark - DeliveryInfoPickUpDelegate

- (void)deliveryInfoPickUpRadioButtonDidTouchUp:(DeliveryInfoPickUpTableViewCell *)sender
{
    self.deliveryMethod = NO;
    [self.tableView reloadData];
}

@end
