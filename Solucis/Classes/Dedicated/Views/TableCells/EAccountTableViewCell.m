//
//  EAccountTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "EAccountTableViewCell.h"

@interface EAccountTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *eAccountLoc;
@property (weak, nonatomic) IBOutlet UILabel *totalPurchaseLoc;
@property (weak, nonatomic) IBOutlet UILabel *eAccountBalanceLoc;
@property (weak, nonatomic) IBOutlet UILabel *balanceAfterPuchasedLoc;
@property (weak, nonatomic) IBOutlet UILabel *ePinLoc;

@end

@implementation EAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.eAccountLoc.text = NSLocalizedString(@"rep_eACCOUNT", "");
    self.totalPurchaseLoc.text = NSLocalizedString(@"rep_total_purchase", "");
    self.eAccountBalanceLoc.text = NSLocalizedString(@"ePoint_balance", "");
    self.balanceAfterPuchasedLoc.text = NSLocalizedString(@"rep_balance_after_purchase", "");
    self.ePinLoc.text = NSLocalizedString(@"rep_ePin", "");
    self.ePinTextField.placeholder = NSLocalizedString(@"enter_epin_code_placeholder", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)eAccountButtonDidTouchUp:(id)sender
{
    [self.delegate eAccountButtonDidTouchUp:self];
}

- (void)activateEpinResponder
{
    [self.ePinTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate ePinDidFinishedEditing:textField.text sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
