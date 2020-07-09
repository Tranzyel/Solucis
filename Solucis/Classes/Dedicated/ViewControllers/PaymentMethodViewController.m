//
//  PaymentMethodViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PaymentMethodViewController.h"
#import "EAccountTableViewCell.h"
#import "AliPayTableViewCell.h"
#import "WeChatPayTableViewCell.h"
#import "PaypalPayTableViewCell.h"
#import "MCOPlaceOrderModel.h"
#import "RDPaymentSuccessViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import "MCOEpointListModel.h"
#import "NSDate+DateRange.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "MCOWeChatPayRequestModel.h"
#import "AppDelegate.h"

#define kPayPalEnvironment PayPalEnvironmentSandbox
//#define kPayPalEnvironment PayPalEnvironmentProduction
//#define kPayPalEnvironment PayPalEnvironmentNoNetwork

static NSString *const EAccountTableViewCellIdentifier = @"EAccountTableViewCellIdentifier";
static NSString *const AliPaymentTableViewCellIdentifier = @"AliPayTableViewCellIdentifier";
static NSString *const WeChatPayTableViewCellIdentifier = @"WeChatPayTableViewCellIdentifier";
static NSString *const PaypalPayTableViewCellIdentifier = @"PaypalPayTableViewCellIdentifier";

@interface PaymentMethodViewController () <EAccountTableViewCellDelegate,AliPayTableViewCellDelegate,WeChatPayTableViewCellDelegate,PayPalPaymentDelegate,PaypalTableViewCellDelegate>
- (IBAction)billSummaryDidTouchUp:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *billSummaryView;
@property (weak, nonatomic) IBOutlet UILabel *subTotal;
@property (weak, nonatomic) IBOutlet UILabel *gst;
@property (weak, nonatomic) IBOutlet UILabel *deliveryCharges;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (nonatomic, assign) CGRect summaryOriginalFrame;
@property (assign) BOOL summaryViewShown;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (nonatomic, strong) NSString *eAccountBalance;
@property (nonatomic, strong) NSString *ePointBalance;
@property (nonatomic,  strong) NSString *ePin;
@property (nonatomic, assign) BOOL aliPay;
@property (nonatomic, assign) BOOL eAccountPay;
@property (nonatomic, assign) BOOL weChatPay;
@property (nonatomic, assign) BOOL payPalPay;
@property (nonatomic, strong) NSString *paymentType;
@property (nonatomic, strong) MCOWeChatPayRequestModel *weChatRequest;

//Localization
@property (weak, nonatomic) IBOutlet UIButton *billSummaryButton;
@property (weak, nonatomic) IBOutlet UILabel *subTotalLoc;
@property (weak, nonatomic) IBOutlet UILabel *deliveryChargesLoc;
@property (weak, nonatomic) IBOutlet UILabel *gstLoc;
@property (weak, nonatomic) IBOutlet UILabel *totalIncGSTLoc;

@end

@implementation PaymentMethodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateDataInSummaryView];
    
    [self.nextPageButton addTarget:self action:@selector(navigateToNextPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EAccountTableViewCell class]) bundle:nil] forCellReuseIdentifier:EAccountTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AliPayTableViewCell class]) bundle:nil] forCellReuseIdentifier:AliPaymentTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeChatPayTableViewCell class]) bundle:nil] forCellReuseIdentifier:WeChatPayTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PaypalPayTableViewCell class]) bundle:nil] forCellReuseIdentifier:PaypalPayTableViewCellIdentifier];
    
    {
        [self.billSummaryButton setTitle:NSLocalizedString(@"rep_bill_summary", "") forState:   UIControlStateNormal];
        self.subTotalLoc.text = NSLocalizedString(@"rep_subtotal", "");
        self.deliveryChargesLoc.text = NSLocalizedString(@"rep_delivery_charges", "");
        self.gstLoc.text = NSLocalizedString(@"rep_gst", "");
        self.totalIncGSTLoc.text = NSLocalizedString(@"rep_total_include_gst", "");
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.type == DistributorTypeRegistration)
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_payment_method", "") currentPage:6 totalPage:TOTAL_PAGES_RD];
        [self.nextPageButton setTitle:NSLocalizedString(@"title_submit_button", "") forState:UIControlStateNormal];
        [self checkEpointBalance];
    }
    else
    {
        [self.progressView setPageName:NSLocalizedString(@"rep_page_payment_method", "") currentPage:5 totalPage:TOTAL_PAGES];
        [self.nextPageButton setTitle:NSLocalizedString(@"rep_button_check_out", "") forState:UIControlStateNormal];
        [self checkAccountBalance];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    self.summaryOriginalFrame = self.billSummaryView.frame;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Override Method

- (void)navigateToNextPage
{
    if (self.eAccountPay)
    {
        if ([self.ePin length] == 0)
        {
            [UIAlertView showErrorWithTitle:@"" message:NSLocalizedString(@"msg_enter_ePin", "")];
            return;
        }
        
        [[RequestMgr shared] checkEPin:self.ePin completionBlock:^(id response)
         {
             if ([response[@"status"] integerValue] == 0)
             {
                 [UIAlertView showErrorWithTitle:@"" message:response[@"msg"]];
                 return ;
             }
             
             if (self.type == DistributorTypeRegistration)
             {
                 [self makeEPointPayment];
             }
             else
             {
                 [self makeEAccountPayment];
             }
             
         } failure:^(NSError *error)
         {
             [UIAlertView showGenericErrorMessage];
             return ;
             
         }];
    }
    else if (self.aliPay)
    {
        [self doAlipayPay];
    }
    else if (self.weChatPay)
    {
        [[RequestMgr shared] requestWeChatPaymentCompletionBlock:^(id response)
        {
            self.weChatRequest = response;
            [self doWeChatPay];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (self.payPalPay)
    {
        [self doPaypalPay];
    }
}


- (void)makeEAccountPayment
{
    [[RequestMgr shared] paymentEAccountWithEpin:self.ePin completionBlock:^(id response)
     {
         NSDictionary *dict = response;
         NSLog(@"EAccount Success : %@" , dict);
         if ([dict[@"status"] integerValue] == 1)
         {
             [UIAlertView showErrorWithTitle:nil message:dict[@"msg"]];
             [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(0)];
         }
         else if ([dict[@"status"] integerValue] == 0)
         {
             [UIAlertView showErrorWithTitle:nil message:dict[@"msg"]];
         }
         
     } failure:^(NSError *error)
     {
         [UIAlertView showGenericErrorMessage];
     }];
}

- (void)makeEPointPayment
{
    [[RequestMgr shared] paymentEPointWithEpin:self.ePin completionBlock:^(id response)
     {
         NSDictionary *dict = response;
         NSLog(@"Epoint Success : %@" , dict);
         if ([dict[@"status"] integerValue] == 1)
         {
             [UIAlertView showErrorWithTitle:nil message:dict[@"msg"]];
             [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(0)];
         }
         else if ([dict[@"status"] integerValue] == 0)
         {
             [UIAlertView showErrorWithTitle:nil message:dict[@"msg"]];
         }
         
     } failure:^(NSError *error)
     {
         [UIAlertView showGenericErrorMessage];
     }];

}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 255.0f;
    }
    
    return 125.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.type == DistributorTypeRegistration)
    {
        return 1;
    }
    else
    {
        return 2;
    }
     
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            EAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EAccountTableViewCellIdentifier];
            cell.delegate = self;
            
            if (self.type == DistributorTypeRegistration)
            {
                cell.accountTypeLbl.text = NSLocalizedString(@"title_ePOINT", "");
            }
            
            if (self.eAccountPay)
            {
                cell.eAccountButton.selected = YES;
            }
            else
            {
                cell.eAccountButton.selected = NO;
            }
            
            cell.eAccountBalance.text = (self.type == DistributorTypeRegistration) ? self.ePointBalance : self.eAccountBalance;
            
            cell.totalPurchase.text = [NSString stringWithFormat:@"%.2f",[[LocalStorage shared] totalPurchasedIncGST]];
            
            float calculatedPrice = [cell.eAccountBalance.text floatValue] - [[LocalStorage shared] totalPurchasedIncGST];
            
            cell.balanceAfPurchase.text =  [NSString stringWithFormat:@"%.2f",calculatedPrice];
            
            if (calculatedPrice < 0)
            {
                cell.balanceAfPurchase.textColor = [UIColor redColor];
            }
            else
            {
                cell.balanceAfPurchase.textColor = [UIColor blackColor];
            }
            
            return cell;
            break;
        }
        case 1:
        {
            AliPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AliPaymentTableViewCellIdentifier];
            cell.delegate = self;
            
            if (self.aliPay)
            {
                cell.aliPayButton.selected = YES;
            }
            else
            {
                cell.aliPayButton.selected = NO;
            }
            
            return cell;
            break;
        }
        case 2:
        {
            PaypalPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PaypalPayTableViewCellIdentifier];
            cell.delegate = self;
            
            if (self.payPalPay)
            {
                cell.paypalPayButton.selected = YES;
            }
            else
            {
                cell.paypalPayButton.selected = NO;
            }            
            return cell;
            break;
        }
        case 3:
        {
            WeChatPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WeChatPayTableViewCellIdentifier];
            cell.delegate = self;
            
            if (self.weChatPay)
            {
                cell.weChatPayButton.selected = YES;
            }
            else
            {
                cell.weChatPayButton.selected = NO;
            }
            return cell;
            break;
        }

        default:
            break;
    }
    return nil;
}


#pragma mark - UITableViewDelegate

- (IBAction)billSummaryDidTouchUp:(id)sender
{
    [self showSummaryView:!self.summaryViewShown];
}

- (void)showSummaryView:(BOOL)show
{
    if (show)
    {
        self.summaryViewShown = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.billSummaryView.frame = CGRectMake(0, self.billSummaryView.frame.origin.y - self.billSummaryView.frame.size.height + 50, self.billSummaryView.frame.size.width, self.billSummaryView.frame.size.height);
            [self.arrow setImage:[UIImage imageNamed:@"arrow-down-white.png"]];
        }];
    }
    else
    {
        self.summaryViewShown = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.billSummaryView.frame = self.summaryOriginalFrame;
            [self.arrow setImage:[UIImage imageNamed:@"arrow-up-white.png"]];
        }];
    }
    
}

- (void)populateDataInSummaryView
{    
    NSArray *placeOrderItems = [[LocalStorage shared] tempPlaceOrderArray];
    __block NSInteger totalPrice = 0;
    __block NSInteger totalGST = 0;
    
    [placeOrderItems enumerateObjectsUsingBlock:^(MCOPlaceOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         totalPrice += obj.itemTotalPrice;
         totalGST += [obj.f_unit_tax integerValue];
     }];
    
    self.subTotal.text = [NSString stringWithFormat:@"USD %.2f",[[LocalStorage shared] subTotalAmount]];
    self.gst.text = [NSString stringWithFormat:@"USD %.2f",(float)totalGST];
    self.deliveryCharges.text = [NSString stringWithFormat:@"USD %.2f",[[LocalStorage shared] totalDeliveryCharges]];
    self.total.text = [NSString stringWithFormat:@"USD %.2f",[[LocalStorage shared] totalPurchasedIncGST]];
}

#pragma mark - EAccountTableViewCellDelegate

- (void)eAccountButtonDidTouchUp:(EAccountTableViewCell *)sender
{
    [self resetRadioButton];
    self.eAccountPay = YES;
    [sender activateEpinResponder];
    [self.tableView reloadData];
}

- (void)ePinDidFinishedEditing:(NSString *)ePin sender:(EAccountTableViewCell *)sender
{
    NSLog(@"EPIN : %@" , ePin);
    self.ePin = ePin;
}


#pragma mark - AliPayPaymentTableViewCellDelegate
- (void)alipayButtonDidTouchUpDelegate:(AliPayTableViewCell *)sender
{
    [self resetRadioButton];
    self.aliPay = YES;
    self.paymentType = AliPayPaymentType;
    [self.tableView reloadData];
}


#pragma mark - WeChatPayTableViewCellDelegate
- (void)weChatpayButtonDidTouchUpDelegate:(WeChatPayTableViewCell *)sender
{
    [self resetRadioButton];
    self.weChatPay = YES;
    [self.tableView reloadData];
}


#pragma mark - PayPalPayTableViewCellDelegate
- (void)paypalPayButtonDidTouchUpDelegate:(PaypalPayTableViewCell *)sender
{
    [self resetRadioButton];
    self.payPalPay = YES;
    [self.tableView reloadData];
}


#pragma mark - AliPay

- (void)doAlipayPay
{
    NSString *appID = AliPayAppID;
    NSString *privateKey = AliPayPrivateKey;
    
    NSString *docType = (self.type == DistributorTypeRegistration) ? @"REG" : @"REP";
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.paymentDocType = docType;
    delegate.paymentType = self.paymentType;
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    order.notify_url = @"http://member.mcoceaninternational.com/payment/PaymentResponseAlipay";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = [[LocalStorage shared] dcTempNo];
    order.biz_content.subject = [[LocalStorage shared] dcTempNo];
    order.biz_content.out_trade_no = [[LocalStorage shared] dcTempNo];
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    
    //[[LocalStorage shared] totalPurchasedIncGST]
    [[RequestMgr shared] getCurrencyRate:@"RMB" completionBlock:^(id response)
    {
        NSDictionary *dict = response;
        float rate = [dict[@"rate"] floatValue];
        
        float totalAmount = [[LocalStorage shared] totalPurchasedIncGST];
        float conversionAmount = totalAmount * rate;
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", conversionAmount]; //商品价格
        //order.biz_content.total_amount = @"0.01";
        
        //将商品信息拼接成字符串
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        NSLog(@"orderSpec = %@",orderInfo);
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderInfo];
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"alipayurlscheme";
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",orderInfoEncoded, signedString];
            
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString
                                      fromScheme:appScheme
                                        callback:^(NSDictionary *resultDic)
            {
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
        }

    } failure:^(NSError *error)
    {
        [UIAlertView showGenericErrorMessage];
    }];
}


#pragma mark - WeChatPay

- (void)doWeChatPay
{
    /*
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = self.weChatRequest.mchID;
    req.prepayId            = self.weChatRequest.prePayID;
    req.nonceStr            = self.weChatRequest.nonceStr;
    req.timeStamp           = [[NSDate date] timeIntervalSince1970];
    req.package             = @"Sign=WXPay";
    req.sign                = self.weChatRequest.sign;
    
    //NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    
    if ([WXApi sendReq:req])
    {
        NSLog(@"Success WXAPI Request");
    }
    else
    {
        NSLog(@"Failed WXAPI REQUEST");
        [UIAlertView showErrorWithTitle:nil message:@"WeiXin API Request Failed"];
    }
    return;
     */
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";

    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil)
    {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil)
        {
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0)
            {
                //NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = self.weChatRequest.mchID;
                req.prepayId            = self.weChatRequest.prePayID;
                req.nonceStr            = self.weChatRequest.nonceStr;
                req.timeStamp           = [[NSDate date] timeIntervalSince1970];
                req.package             = @"Sign=WXPay";
                req.sign                = self.weChatRequest.sign;
                
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                
                if ([WXApi sendReq:req])
                {
                    NSLog(@"Success WXAPI Request");
                }
                else
                {
                    NSLog(@"Failed WXAPI REQUEST");
                    [UIAlertView showErrorWithTitle:nil message:@"WeiXin API Request Failed"];
                }
                //日志输出
                //return @"";
            }else{
                NSLog(@"Dict Error : %@" ,[dict objectForKey:@"retmsg"]);
            }
        }else{
            NSLog(@"Json Error : %@" , error);
        }
    }else
    {
        NSLog(@"WeChat Reponse Nil");
    }
}


#pragma mark - PayPal

-(void)doPaypalPay
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageCode"];
    
    /*Paypal Configurations*/
    PayPalConfiguration *ppConfig = [[PayPalConfiguration alloc] init];
    ppConfig.acceptCreditCards = YES;
    ppConfig.merchantName = @"Awesome Shirts, Inc.";
    ppConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    ppConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    ppConfig.languageOrLocale = ([language length] > 0) ? language : @"zh-Hans";
    ppConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
    
    [PayPalMobile preconnectWithEnvironment:kPayPalEnvironment];
    
    /*Paypal Payment*/
    float totalAmount = [[LocalStorage shared] totalPurchasedIncGST];
    
    NSDecimalNumber *total = [[NSDecimalNumber alloc] initWithFloat:totalAmount];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = [[LocalStorage shared] dcTempNo];
    payment.items = nil;
    payment.paymentDetails = nil;
    
    if (!payment.processable)
    {
        NSLog(@"Invalid amount : %.2f" , totalAmount);
    }
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:ppConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}


#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"PayPal Payment Success!");
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    NSLog(@"PayPal Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment
{
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}


#pragma mark - Private Method

- (void)resetRadioButton
{
    self.aliPay = NO;
    self.weChatPay = NO;
    self.eAccountPay = NO;
    self.payPalPay = NO;
}

- (void)checkAccountBalance
{
    [[RequestMgr shared] checkEAccountBalanceCompletionBlock:^(id response)
     {
         self.eAccountBalance = [NSString stringWithFormat:@"%.2f",[response[@"balance"] floatValue]];
         [self.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
    
}


- (void)checkEpointBalance
{
    NSString *dateFrom , *dateTo;
    [NSDate dateFromRange:AllTimeDateRangeType dateFrom:&dateFrom dateTo:&dateTo];
    [[RequestMgr shared] requestEpointFromDate:dateFrom toDate:dateTo completionBlock:^(id response)
     {
         
         NSArray *list = [[LocalStorage shared] ePointLists];
         
         if (list.count)
         {
             MCOEpointListModel *model = list[0];
             self.ePointBalance = model.epoint;
         }
         [self.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
    
}


- (void)updatePaymentWithTransactionNo:(NSString *)transactionNo
{
    NSString *docType = (self.type == DistributorTypeRegistration) ? @"REG" : @"REP";
    
    [[RequestMgr shared] updatePaymentStatusWithDocType:docType paymentType:self.paymentType transactionNo:transactionNo completionBlock:^(id response)
     {
         if ([response[@"status"] integerValue] == 1)
         {
             [self popToHome];
         }
         else
         {
             [UIAlertView showErrorWithTitle:@"" message:response[@"msg"]];
         }
         
     } failure:^(NSError *error)
     {
         
     }];
}


- (void)popToHome
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NavigateToNextViewControllerNotification object:@(0)];
}
@end
