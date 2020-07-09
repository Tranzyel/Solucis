//
//  RDContactInfoTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDContactInfoTableViewCell.h"

@interface RDContactInfoTableViewCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *mobileLoc;
@property (weak, nonatomic) IBOutlet UILabel *corespondanceLoc;

@end

@implementation RDContactInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contactMobileTextField.delegate = self;
    
    self.countryCodeLoc.text = NSLocalizedString(@"reg_country_code", "");
    self.mobileLoc.text = NSLocalizedString(@"reg_mobile", "");
    self.corespondanceLoc.text = NSLocalizedString(@"reg_correspondance", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark - UIAction

- (IBAction)countryDropDown:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self.delegate countryCodeButtonDidTouchUp:button cell:self];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate countryCodeMobileTextFieldDidFinishedEditing:textField.text];
}

@end
