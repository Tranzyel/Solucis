//
//  UpdateProfileMemberCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-22.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "UpdateProfileMemberCell.h"

@interface UpdateProfileMemberCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *memberCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLoc;
@property (weak, nonatomic) IBOutlet UILabel *memberICLoc;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLoc;

@end

@implementation UpdateProfileMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.memberCodeLoc.text = NSLocalizedString(@"profile_memberCode_title", "");
    self.memberNameLoc.text = NSLocalizedString(@"profile_name_title", "");
    self.memberICLoc.text = NSLocalizedString(@"update_profile_member_identification", "");
    self.descriptionLoc.text = NSLocalizedString(@"update_profile_member_desc", "");
    self.memberIC.delegate = self;
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
    [self.delegate memberICDidFinishEditing:textField.text cell:self];
}
@end
