//
//  NewRegisterTeamInfoCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-09-03.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "NewRegisterTeamInfoCell.h"

@interface NewRegisterTeamInfoCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *companyCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *sponsorLoc;
- (IBAction)segmentedControlDidTouchUp:(id)sender;

@end

@implementation NewRegisterTeamInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sponsorNameTF.delegate = self;
    self.sponsorCodeTF.delegate = self;
    
    self.companyCodeLoc.text = NSLocalizedString(@"reg_new_company_code", @"");
    self.sponsorLoc.text = NSLocalizedString(@"reg_verify_sponsor", @"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)companyCodeDropDown:(id)sender {
    [self.delegate companyDropDownDidTouchUp:sender cell:self];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate sponsorDidFinishEditing:textField cell:self];
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)segmentedControlDidTouchUp:(id)sender {
    
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    NSNumber *number = [NSNumber numberWithInteger:sc.selectedSegmentIndex];
    [self.delegate segmentedControlDidTouchUp:![number boolValue] cell:self];
}
@end
