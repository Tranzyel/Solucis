//
//  ForgetPasswordView.m
//  Solucis
//
//  Created by Lam Si Mon on 18-10-10.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "ForgetPasswordView.h"

@interface ForgetPasswordView() <UITextFieldDelegate>
@end

@implementation ForgetPasswordView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.memberCodeLoc.text = NSLocalizedString(@"profile_memberCode_title", @"");
    self.emailCodeLoc.text =NSLocalizedString(@"profile_email_title", @"");
    [self.submitButton setTitle:NSLocalizedString(@"title_submit_button", "") forState:UIControlStateNormal];
}

- (id)initNib
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ForgetPasswordView class]) owner:self options:nil];
    
    for (id obj in array)
    {
        if ([obj isKindOfClass:[ForgetPasswordView class]])
        {
            return obj;
        }
    }
    return nil;
}


- (IBAction)singleTapAction:(id)sender
{
    [self hideView];
}

- (IBAction)submitButton:(id)sender {
    [self.delegate submitButtonDidTouchUp:self];
}


- (void)hideView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    }];
    [self endEditing:YES];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"String : %@" , textField.text);    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
