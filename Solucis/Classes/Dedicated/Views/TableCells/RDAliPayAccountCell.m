//
//  RDAliPayAccountCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-17.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "RDAliPayAccountCell.h"

@interface RDAliPayAccountCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *alipayAccNoLoc;
@property (weak, nonatomic) IBOutlet UILabel *alipayAccNameLoc;
@end

@implementation RDAliPayAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.alipayAccNoLoc.text = NSLocalizedString(@"reg_alipay_account_number", "");
    self.alipayAccNameLoc.text = NSLocalizedString(@"reg_alipay_account_name", "");
    self.alipayAccNoTF.delegate = self;
    self.alipayAccNameTF.delegate = self;
    
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
    [self.delegate alipayAccountFieldDidFinishEditing:textField.text fieldType:textField.tag];
}

@end
