//
//  NewRegisterMemberInfoCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-09-03.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "NewRegisterMemberInfoCell.h"

@interface NewRegisterMemberInfoCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nationalityLoc;
@property (weak, nonatomic) IBOutlet UILabel *nameLoc;
@property (weak, nonatomic) IBOutlet UILabel *emailLoc;
@property (weak, nonatomic) IBOutlet UILabel *passportLoc;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLoc;
@property (weak, nonatomic) IBOutlet UILabel *passwordLoc;
@property (weak, nonatomic) IBOutlet UILabel *verifyPasswordLoc;

- (IBAction)memberInfoDropDownDidTouchUp:(id)sender;
@end


@implementation NewRegisterMemberInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameTF.delegate = self;
    self.emailTF.delegate = self;
    self.passportTF.delegate = self;
    self.mobileNumberTF.delegate = self;
    self.passwordTF.delegate = self;
    self.verifyPasswordTF.delegate = self;

    self.nationalityLoc.text = NSLocalizedString(@"reg_nationality", @"");
    self.nameLoc.text = NSLocalizedString(@"reg_new_name", @"");
    self.emailLoc.text = NSLocalizedString(@"profile_email_title", @"");
    self.passportLoc.text = NSLocalizedString(@"reg_new_ic_or_passport", @"");
    self.mobileNumberLoc.text = NSLocalizedString(@"reg_mobile", @"");
    self.passwordLoc.text = NSLocalizedString(@"password_placeholder", @"");
    self.verifyPasswordLoc.text = NSLocalizedString(@"reg_new_verify_password", @"");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)memberInfoDropDownDidTouchUp:(id)sender {
    
    [self.delegate memberInfoDropDownDidTouchUp:sender cell:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.delegate textFieldDidEndEditing:textField cell:self];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
