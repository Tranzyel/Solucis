//
//  BaseMenuViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-03-14.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "BaseMenuViewController.h"

@interface BaseMenuViewController ()

@end

@implementation BaseMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showUserProfileIcon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method

- (void)showUserProfileIcon
{
    
}


- (void)showMenuIcon
{
}


- (void)hideMenuIcon
{
    
}

- (void) leftBarButtonTouchUp:(id) sender
{
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

@end
