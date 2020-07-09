//
//  BaseViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-03-03.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import <SlideNavigationController.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    
    if ([self isKindOfClass:[LoginViewController class]])
    {
        //[self hideNavigationBar];
    }
    else
    {
        [self showNavigationBar];
    }
    
    if (![[LocalStorage shared] loggedIn])
    {
        [self showBackButton];
    }
    
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Private Method

- (void)hideNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)showNavigationBar
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)showBackButton
{
    self.navigationItem.hidesBackButton = YES;
    
    UIImage * backButtonImage = [UIImage imageNamed: @"ic-back.png"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped:)];
    [backButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SlideNavigationControllerDelegate

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


#pragma mark - UINavigationController Appearance 

- (void)setupNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

@end
