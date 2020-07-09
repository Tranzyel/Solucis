//
//  UIAlertView+Error.m
//  Solucis
//
//  Created by Lam Si Mon on 16-10-05.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "UIAlertView+Error.h"

@implementation UIAlertView (Error)

+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

+ (void)showGenericErrorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedString(@"msg_unexpected_error_please_try_again", "")
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

+ (void)showFieldsCannotBeEmptyMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedString(@"msg_empty_fields", "")
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
    
}

+ (void)showPasswordNotMatched
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedString(@"msg_password_not_match", "")
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
    
}
@end
