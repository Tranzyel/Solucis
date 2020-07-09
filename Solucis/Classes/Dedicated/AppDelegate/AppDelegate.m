//
//  AppDelegate.m
//  Solucis
//
//  Created by Lam Si Mon on 16-03-02.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PreLoginViewController.h"
#import "LeftSideRevealViewController.h"
#import <SlideNavigationController.h>
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "NSDate+DateRange.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UIDevice-Hardware/UIDevice-Hardware.h>
//GGWP
@interface AppDelegate ()
@property ( nonatomic , strong ) SlideNavigationController *slideNavigationController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageCode"];
    
    if ([language length] > 0)
    {
        NSLog(@"Selected lang ; %@" , [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageCode"]);
        [NSBundle setLanguage:[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageCode"]];
    }
    else
    {
        [NSBundle setLanguage:@"zh-Hans"];
    }
    
    //LoginViewController *loginVC = [[LoginViewController alloc] init];
    PreLoginViewController *loginVC = [[PreLoginViewController alloc] init];
    self.slideNavigationController = [[SlideNavigationController alloc] initWithRootViewController:loginVC];

    LeftSideRevealViewController *leftSideMenuController = [[LeftSideRevealViewController alloc] init];
    [leftSideMenuController viewDidLoad];
    self.slideNavigationController.leftMenu = leftSideMenuController;
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"btn-menu.png"] forState:UIControlStateNormal];
    [button addTarget:self.slideNavigationController action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.slideNavigationController.leftBarButtonItem = leftBarButtonItem;
    self.slideNavigationController.portraitSlideOffset = 80;
    [self.slideNavigationController setEnableSwipeGesture:NO];
        
    self.slideNavigationController.menuRevealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc] initWithMaximumFadeAlpha:1.0f fadeColor:[UIColor blackColor] andMinimumScale:.9f];
    self.slideNavigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.slideNavigationController.view.layer.shadowRadius = 10;
    self.slideNavigationController.view.layer.shadowOpacity = 1;
    self.slideNavigationController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.slideNavigationController.view.bounds].CGPath;
    
    self.window.rootViewController = self.slideNavigationController;
    [self.window makeKeyAndVisible];
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                           PayPalEnvironmentSandbox    : @"AFcWxV21C7fd0v3bYYYRCpSSRl31ATLq8nvxV-ymEhcNS.d.vMrANg3K"}];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 111 = %@",resultDic);
            
            NSInteger statusCode = [resultDic[@"resultStatus"] integerValue];
            
            if (statusCode == 9000)
            {
                NSString *resultString = resultDic[@"result"];
                NSData *resultData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSDictionary *convertedResultDict = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingAllowFragments error:&error];
                
                if (error)
                {
                    NSLog(@"Failed to convert to Dict");
                }
                else
                {
                    NSString *tradeNo = convertedResultDict[@"alipay_trade_app_pay_response"][@"trade_no"];
                    [self updatePaymentWithTransactionNo:tradeNo];
                    NSLog(@"Payment Success With Trade No : %@" , tradeNo);
                }
            }

        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 222 = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 333 = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 444 = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}


- (void)updatePaymentWithTransactionNo:(NSString *)transactionNo
{
    [[RequestMgr shared] updatePaymentStatusWithDocType:self.paymentDocType paymentType:self.paymentType transactionNo:transactionNo completionBlock:^(id response)
     {
         if ([response[@"status"] integerValue] == 1)
         {
             [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(0)];
         }
         else
         {
             [UIAlertView showErrorWithTitle:@"" message:response[@"msg"]];
         }
         
     } failure:^(NSError *error)
     {
         
     }];
}
@end
