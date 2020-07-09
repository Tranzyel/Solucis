//
//  RDMemberInfoTableViewCell.m
//  :
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDMemberInfoTableViewCell.h"

@interface RDMemberInfoTableViewCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nationalityLoc;
@property (weak, nonatomic) IBOutlet UILabel *registerTypeLoc;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLoc;
@property (weak, nonatomic) IBOutlet UILabel *dobLoc;
@property (weak, nonatomic) IBOutlet UILabel *languageLoc;
@property (weak, nonatomic) IBOutlet UILabel *languageMessageLoc;

@end

@implementation RDMemberInfoTableViewCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.identity.delegate = self;
    self.memberName.delegate = self;
    
    self.nationalityLoc.text = NSLocalizedString(@"reg_nationality", "");
    self.registerTypeLoc.text = NSLocalizedString(@"reg_register_type", "");
    self.memberNameLoc.text = NSLocalizedString(@"reg_member_name", "");
    self.dobLoc.text = NSLocalizedString(@"reg_dob", "");
    self.languageLoc.text = NSLocalizedString(@"reg_language", "");
    self.languageMessageLoc.text = NSLocalizedString(@"reg_language_description", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)pickerButtonDidTouchUp:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    switch ([sender tag])
    {
        case PickerTypeNationality:
        case PickerTypeRegisterType:
        case PickerTypeDOB:
        case PickerTypeLanguage:
        case PickerTypeID:
        {
            [self.delegate memberInfoCellOptionsButtonDidTouchUp:button cell:self];
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
    [self.delegate memberInfoTextFieldDidFinishedEditing:textField.text textField:textField.tag];
}
@end
