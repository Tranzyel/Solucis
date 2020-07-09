//
//  EAccountTransferTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-10-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "EAccountTransferTableViewCell.h"

@interface EAccountTransferTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *ePinLbl;
@property (weak, nonatomic) IBOutlet UILabel *memberIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLbl;
@property (weak, nonatomic) IBOutlet UILabel *remarkLbl;
@end

@implementation EAccountTransferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.memberIDTF.delegate = self;
    self.memberNameTF.delegate = self;
    self.amountTF.delegate = self;
    self.remarkTF.delegate = self;
    self.ePinTF.delegate = self;
    
    self.ePinLbl.text = NSLocalizedString(@"rep_ePin", "");
    self.memberIDLabel.text = NSLocalizedString(@"rep_member_id", "");
    self.memberNameLabel.text = NSLocalizedString(@"rep_member_name", "");
    self.amountLbl.text = NSLocalizedString(@"eTransfer_amount", "");
    self.remarkLbl.text = NSLocalizedString(@"eTransfer_remark", "");
    [self.verifyButton setTitle:NSLocalizedString(@"eTransfer_verify_button", "") forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)verifyAction:(id)sender
{
    NSLog(@"GGWP");
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate eAccountTransferTextFieldDidFinishEditing:textField.text textField:textField sender:self];
}

@end
