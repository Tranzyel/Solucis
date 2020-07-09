//
//  WithdrawalTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-09-05.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "WithdrawalTableViewCell.h"

@interface WithdrawalTableViewCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *amountLoc;
@property (weak, nonatomic) IBOutlet UILabel *withdrawMethodLoc;
@property (weak, nonatomic) IBOutlet UILabel *ePinLoc;
@end


@implementation WithdrawalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.amountTF.delegate = self;
    self.epinTF.delegate = self;
    
    self.amountLoc.text = NSLocalizedString(@"eTransfer_amount", "");
    self.withdrawMethodLoc.text = NSLocalizedString(@"withdrawal_method", "");
    self.ePinLoc.text = NSLocalizedString(@"rep_ePin", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)withdrawDropDown:(id)sender {
    [self.delegate withdrawDropDownDidTouchUp:sender cell:self];
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
