//
//  RDBankAccountInfoTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-17.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "RDBankAccountInfoTableViewCell.h"

@interface RDBankAccountInfoTableViewCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *chinaBankLoc;
@property (weak, nonatomic) IBOutlet UILabel *bankAccountNameLoc;
@property (weak, nonatomic) IBOutlet UILabel *bankAccountNoLoc;
@property (weak, nonatomic) IBOutlet UILabel *bankAccountNIRCLoc;
@property (weak, nonatomic) IBOutlet UILabel *chinsBankCountryLoc;
@property (weak, nonatomic) IBOutlet UILabel *bankBranchLoc;

@end

@implementation RDBankAccountInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.chinaBankLoc.text = NSLocalizedString(@"reg_china_bank", "");
    self.bankAccountNameLoc.text = NSLocalizedString(@"reg_bank_account_name", "");
    self.bankAccountNoLoc.text = NSLocalizedString(@"reg_bank_account_number", "");
    self.bankAccountNIRCLoc.text = NSLocalizedString(@"reg_bank_account_nirc", "");
    self.chinsBankCountryLoc.text = NSLocalizedString(@"reg_china_bank_country", "");
    self.bankBranchLoc.text = NSLocalizedString(@"reg_china_bank_branch", "");
    
    self.bankAccNameTF.delegate = self;
    self.bankAccNoTF.delegate = self;
    self.bankAccNIRCTF.delegate = self;
    self.bankBranch.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)dropDownButtonDidTouchUp:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    switch ([sender tag])
    {
        case BankInfoPickerChinaBank:
        case BankInfoPickerChinaState:
        case BankInfoPickerChinaDistrict:
        {
            [self.delegate bankAccountInfoCellDropDownDidTouchUp:button cell:self];
            break;
        }
        default:
        {break;}
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate bankAccountTextFieldDidFinishEditing:textField.text type:textField.tag];
}

@end
