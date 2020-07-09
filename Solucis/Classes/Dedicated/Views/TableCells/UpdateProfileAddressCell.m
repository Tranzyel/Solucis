//
//  UpdateProfileAddressCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-23.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "UpdateProfileAddressCell.h"

@interface UpdateProfileAddressCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *address1Loc;
@property (weak, nonatomic) IBOutlet UILabel *address2Loc;
@property (weak, nonatomic) IBOutlet UILabel *address3Loc;
@property (weak, nonatomic) IBOutlet UILabel *address4Loc;
@property (weak, nonatomic) IBOutlet UILabel *postCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *mobileLoc;
@property (weak, nonatomic) IBOutlet UILabel *emailLoc;
@property (weak, nonatomic) IBOutlet UILabel *countryLoc;
@property (weak, nonatomic) IBOutlet UILabel *cityLoc;

@end

@implementation UpdateProfileAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.address1Loc.text = [NSLocalizedString(@"rep_delivery_address", "") uppercaseString];
    self.address2Loc.text = [NSLocalizedString(@"rep_delivery_address2", "") uppercaseString];
    self.address3Loc.text = [NSLocalizedString(@"rep_delivery_address3", "") uppercaseString];
    self.address4Loc.text = [NSLocalizedString(@"rep_delivery_address4", "") uppercaseString];
    self.postCodeLoc.text = [NSLocalizedString(@"profile_postCode_title", "") uppercaseString];
    self.countryCodeLoc.text = [NSLocalizedString(@"reg_country_code", "") uppercaseString];
    self.mobileLoc.text = [NSLocalizedString(@"reg_mobile", "") uppercaseString];
    self.emailLoc.text = [NSLocalizedString(@"profile_email_title", "") uppercaseString];
    self.countryLoc.text = [NSLocalizedString(@"rep_country", "") uppercaseString];
    self.cityLoc.text = [NSLocalizedString(@"rep_city", "") uppercaseString];
    
    self.address1.delegate = self;
    self.address2.delegate = self;
    self.address3.delegate = self;
    self.address4.delegate = self;
    self.postCode.delegate = self;
    self.mobileNumber.delegate = self;
    self.email.delegate = self;
    self.city.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate profileFieldDidFinishEditing:textField.text cell:self fieldType:textField.tag];
}

#pragma mark - IBAction

- (IBAction)dropDownButtonDidTouchUp:(id)sender {
    UIButton *button =(UIButton *)sender;
    
    [self.delegate dropDownButtonDidTouchUp:button.tag cell:self];
}
@end
