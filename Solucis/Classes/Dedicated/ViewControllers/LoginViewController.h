//
//  LoginViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-03-02.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController <SlideNavigationControllerDelegate>
- (IBAction)signInAction:(id)sender;
- (IBAction)forgotPWAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPWButton;
@property (weak, nonatomic) IBOutlet UIButton *registerNewAccButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end
