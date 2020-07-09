//
//  ShopViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "ShopViewController.h"
#import "MemberViewController.h"
#import "PlaceOrderViewController.h"
#import "PurchaseInfoViewController.h"
#import "DeliveryInfoViewController.h"
#import "PurchaseInfoViewController.h"
#import "PaymentMethodViewController.h"
#import "RDMemberViewController.h"
#import "RDVerifyViewController.h"
#import "RDPaymentSuccessViewController.h"

@interface ShopViewController ()
@property ( nonatomic , strong ) UIButton *proceedButton;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self showBackButton];
    
    if (self.type == DistributorTypeRepurchase)
    {
        self.title = NSLocalizedString(@"nav_bar_repurchase_title", "");
    }
    else
    {
        self.title = NSLocalizedString(@"nav_bar_register_distributor_title", "");
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSLog(@"Class %@",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Method
- (void)navigateToNextPage
{
//    NSString *className = NSStringFromClass([self class]);
//    UIViewController* controller = [[NSClassFromString(className) alloc] init];
    id viewController = nil;
    
    if (self.type == DistributorTypeRepurchase)
    {
        if ([self isKindOfClass:[MemberViewController class]])
        {
            PlaceOrderViewController *controller = [[PlaceOrderViewController alloc] init];
            viewController = controller;
        }
        else if ([self isKindOfClass:[PlaceOrderViewController class]])
        {
            DeliveryInfoViewController *controller = [[DeliveryInfoViewController alloc] init];
            viewController = controller;
        }
        else if ([self isKindOfClass:[DeliveryInfoViewController class]])
        {
            PurchaseInfoViewController *controller = [[PurchaseInfoViewController alloc] init];
            viewController = controller;
        }
        else if ([self isKindOfClass:[PurchaseInfoViewController class]])
        {
            PaymentMethodViewController *controller = [[PaymentMethodViewController alloc] init];
            viewController = controller;
        }
        else if ([self isKindOfClass:[PaymentMethodViewController class]])
        {
            [UIAlertView showErrorWithTitle:@"" message:@"Payment not available at the moment"];
            return;
        }
    }
    else
    {
        if ([self isKindOfClass:[RDMemberViewController class]])
        {
            RDVerifyViewController *controller = [[RDVerifyViewController alloc] init];
            controller.type = DistributorTypeRegistration;
            viewController = controller;
        }
        else if ([self isKindOfClass:[RDVerifyViewController class]])
        {
            PlaceOrderViewController *controller = [[PlaceOrderViewController alloc] init];
            controller.type = DistributorTypeRegistration;
            viewController = controller;
        }
        else if ([self isKindOfClass:[PlaceOrderViewController class]])
        {
            DeliveryInfoViewController *controller = [[DeliveryInfoViewController alloc] init];
            controller.type = DistributorTypeRegistration;
            viewController = controller;
        }
        else if ([self isKindOfClass:[DeliveryInfoViewController class]])
        {
            PurchaseInfoViewController *controller = [[PurchaseInfoViewController alloc] init];
            controller.type = DistributorTypeRegistration;
            viewController = controller;
        }
        else if ([self isKindOfClass:[PurchaseInfoViewController class]])
        {
            PaymentMethodViewController *controller = [[PaymentMethodViewController alloc] init];
            controller.type = DistributorTypeRegistration;
            viewController = controller;
        }
        else if ([self isKindOfClass:[PaymentMethodViewController class]])
        {
            RDPaymentSuccessViewController *controller = [[RDPaymentSuccessViewController alloc] init];
            controller.title = NSLocalizedString(@"nav_bar_register_distributor_title", "");;
            viewController = controller;
        }
    }

    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Lazy Initialization

- (ProgressView *)progressView
{
    if (_progressView == nil)
    {
        _progressView = [[ProgressView alloc] initNib];
        [_progressView adjustPositionForViewController:self];
    }
    
    return _progressView;
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

@end
