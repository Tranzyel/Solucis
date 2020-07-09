//
//  PreProductDetailsViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-12-02.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PreProductDetailsViewController.h"

@interface PreProductDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PreProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadHTMLString:self.productDetails baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

@end
