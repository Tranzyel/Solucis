//
//  RDPayPalAccountInfoTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-06.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDPayPalAccountInfoTableViewCell.h"

@interface RDPayPalAccountInfoTableViewCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ppNationalityLoc;
@property (weak, nonatomic) IBOutlet UILabel *ppEmailLoc;
@property (weak, nonatomic) IBOutlet UILabel *ppAccNameLoc;

@end

@implementation RDPayPalAccountInfoTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.paypalEmailTF.delegate = self;
    self.ppAccName.delegate = self;
    self.ppNationalityLoc.text = NSLocalizedString(@"reg_paypal_nationality", "");
    self.ppEmailLoc.text = NSLocalizedString(@"reg_paypal_email", "");
    self.ppAccNameLoc.text = NSLocalizedString(@"reg_paypal_account_name", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)paypalNationalityDropdown:(id)sender
{
    [self.delegate paypalNationalityButtonDidTouchUp:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.paypalEmailTF) {
        [self.delegate paypalEmailTextFieldDidFinishedEditing:textField.text];
    }else if (textField == self.ppAccName) {
        [self.delegate paypalAccountNameTextFieldDidFinishedEditing:textField.text];
    }
    
}

@end
