//
//  LoginViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-03-02.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "ForgetPasswordView.h"
#import <BEMCheckBox/BEMCheckBox.h>

@interface LoginViewController () <UITextFieldDelegate,BEMCheckBoxDelegate,ForgetPasswordViewDelegate>
@property (nonatomic, strong) NSArray *availableLocalizations;
@property (weak, nonatomic) IBOutlet UITableView *languageTableView;
@property (strong, nonatomic) IBOutlet UIView *languageView;
@property (weak, nonatomic) IBOutlet UIView *languageBackground;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property (weak, nonatomic) IBOutlet UILabel *rememberMeLbl;
@property (nonatomic, strong) ForgetPasswordView *forgotPasswordView;
@property (nonatomic, strong) NSString *memberCode , *email;
@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self localizedStrings];
    self.signInButton.layer.cornerRadius = 20.0;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCheckBoxConfig];
    
    self.forgotPasswordView = [[ForgetPasswordView alloc] initNib];
    self.forgotPasswordView.delegate = self;
    [self.view addSubview:self.forgotPasswordView];
    self.forgotPasswordView.alpha = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)signInAction:(id)sender
{
//    self.usernameTF.text = @"8883524873CN";
//    self.passwordTF.text = @"5550";
    
//    self.usernameTF.text = @"8880688319MY";
//    self.passwordTF.text = @"cis8888cis";
#ifdef DEBUG
    self.usernameTF.text = @"8884173997MY";
    self.passwordTF.text = @"5678";
#endif
//    self.usernameTF.text = @"8883727406MY";
//    self.passwordTF.text = @"3456";
    
    [[RequestMgr shared] loginWithUsername:self.usernameTF.text password:self.passwordTF.text completionBlock:^(id response)
    {
        if ([response[@"status"] integerValue] == 0)
        {
            [UIAlertView showErrorWithTitle:@"" message:response[@"msg"]];
            return ;
        }
        
        if (self.checkBox.on)
        {
            [[LocalStorage shared] storeObject:self.usernameTF.text forKey:RememberMeDidActivate];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:RememberMeDidActivate];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
        [[LocalStorage shared] setLoggedIn:YES];
        MenuViewController * controller = [[MenuViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    } failure:^(NSError *error)
    {
        [UIAlertView showErrorWithTitle:@"" message:NSLocalizedString(@"login_error_message", "")];
    }];
}


- (IBAction)forgotPWAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.forgotPasswordView.alpha = 1.0;
    }];
    
    [self.forgotPasswordView.memberCodeTF becomeFirstResponder];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    if (![[LocalStorage shared] loggedIn])
    {
        return NO;
    }
    return YES;
}


#pragma mark - Private Method

- (void)localizedStrings
{
    self.title = [NSLocalizedString(@"login_title", "") uppercaseString];
    [self.signInButton setTitle:NSLocalizedString(@"login_signIn", @"") forState:UIControlStateNormal];
    [self.forgotPWButton setTitle:NSLocalizedString(@"login_forgotPassword", @"") forState:UIControlStateNormal];
    [self.registerNewAccButton setTitle:NSLocalizedString(@"login_register_new_account", @"") forState:UIControlStateNormal];
    self.usernameTF.placeholder = NSLocalizedString(@"username_placeholder", "");
    self.passwordTF.placeholder = NSLocalizedString(@"password_placeholder", "");
    self.rememberMeLbl.text = NSLocalizedString(@"login_remember_me", "");
}


- (void)setupCheckBoxConfig
{
    self.checkBox.delegate = self;
    self.checkBox.boxType = BEMBoxTypeSquare;
    self.checkBox.onAnimationType = BEMAnimationTypeBounce;
    self.checkBox.onTintColor = [UIColor navigationBarColor];
    self.checkBox.onCheckColor = [UIColor navigationBarColor];
    
    if ([[[LocalStorage shared] getUserDefaultsObjectForKey:RememberMeDidActivate] length] > 0)
    {
        self.usernameTF.text = [[LocalStorage shared] getUserDefaultsObjectForKey:RememberMeDidActivate];
        self.checkBox.on = YES;
    }
    else
    {
        self.usernameTF.text = @"";
        self.checkBox.on = NO;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
    

#pragma mark - BEMCheckBoxDelegate

- (void)didTapCheckBox:(BEMCheckBox*)checkBox
{
}


#pragma mark - ForgotPasswordViewDelegate

- (void)submitButtonDidTouchUp:(nonnull ForgetPasswordView *)view
{
    [view endEditing:YES];
    
    self.memberCode = view.memberCodeTF.text;
    self.email = view.emailTF.text;
    
    [[RequestMgr shared] resetPassword:self.memberCode email:self.email completionBlock:^(id response) {
        NSDictionary *dict = response;
        
        if (dict) {
            [UIAlertView showErrorWithTitle:@"" message:dict[@"msg"]];
        }
        [view hideView];
    } failure:^(NSError *failure) {
        [UIAlertView showGenericErrorMessage];
        [view hideView];
    }];
    
    
}

@end

