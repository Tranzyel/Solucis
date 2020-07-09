//
//  AboutUsViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *urlString = @"http://mcocean.com.cn";
    
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.webView setScalesPageToFit:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    if (![[LocalStorage shared] loggedIn])
    {
        return NO;
    }
    return YES;
}

#pragma mark - UIWebviewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[RequestMgr shared] showLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[RequestMgr shared] hideLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[RequestMgr shared] hideLoading];
}

@end
