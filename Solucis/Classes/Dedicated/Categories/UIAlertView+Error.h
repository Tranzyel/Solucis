//
//  UIAlertView+Error.h
//  Solucis
//
//  Created by Lam Si Mon on 16-10-05.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Error)
+ (void)showGenericErrorMessage;
+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showFieldsCannotBeEmptyMessage;
+ (void)showPasswordNotMatched;
@end
