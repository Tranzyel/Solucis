//
//  RequestMgr.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RequestMgr.h"
#import "MCOLoginModel.h"
#import "MCOAnnoucementListModel.h"
#import "MCOPersonalSalesSubmissionModel.h"
#import "MCOAnnouncementListDetailModel.h"
#import "MCOPersonalSalesSubmissionData.h"
#import "MCOMemberInfo.h"
#import "SubmitNewJoinInfo.h"
#import "MCOPlaceOrderModel.h"
#import "MCOAllSalesSubmissionModel.h"
#import "MCOCountryList.h"
#import "MCOStateList.h"
#import "MCOEAccStatementListModel.h"
#import "MCOEpointListModel.h"
#import "MCOBonusSummaryModel.h"
#import "NSDate+DateRange.h"
#import "MCOExclusiveStoreModel.h"
#import "MCONationalityModel.h"
#import "MCORegisterTypeModel.h"
#import "MCOIDTypeModel.h"
#import "MCOLanguageModel.h"
#import "MCOZoneCodeModel.h"
#import "MobileSignUpInfo.h"
#import "UpdateShippingAddressInfo.h"
#import "MCOShippingAddressModel.h"
#import "MCOWeChatPayRequestModel.h"
#import "MCOChinaBankList.h"
#import "MCOChinaBankStateList.h"
#import "MCOChinaBankDistrictList.h"
#import "MCOCompanyCode.h"
#import <AFNetworking/AFNetworking.h>
#import <UIDevice-Hardware/UIDevice-Hardware.h>

// /*Live
 static NSString *const baseURL = @"http://admin.mcoceaninternational.com/index.php/api/mobile/";
 static NSString *const baseURLSignUp = @"http://admin.mcoceaninternational.com/index.php/api/MobileSignUp/";
 static NSString *const baseURLNewSignUp = @"http://admin.mcoceaninternational.com/index.php/api/MobileNewJoin/";
// */
 /*Test
static NSString *const baseURL = @"http://admin.mcoceaninternational.com/index.php/api/mobile/";
static NSString *const baseURLSignUp = @"http://admin.mcoceaninternational.com/index.php/api/MobileSignUp/";
 */
static NSString *const method_Login = @"login";
static NSString *const method_PersonalSalesSubmission = @"PersonalSalesSubmission";
static NSString *const method_AllSalesSubmission = @"AllSalesSubmission";
static NSString *const method_MemberInfo = @"MemberInfoAPP";
static NSString *const method_MemberUpdateInfo = @"Member_UpdateInfo";
static NSString *const method_AnnouncementList = @"AllAnnouncement";
static NSString *const method_AnnouncementListDetails = @"AnnouncementList_details";
static NSString *const method_SalesRequest = @"SalesRequest";
static NSString *const method_ProductListRequest = @"productListRequest";
static NSString *const method_EPointRequest = @"EPointRequest";
static NSString *const method_EWalletRequest = @"EWalletRequest";
static NSString *const method_BonusRequest = @"BonusRequest";
static NSString *const method_StateListCode = @"StateListCode";
static NSString *const method_CountryList = @"CountryListCode";
static NSString *const method_ePointRequest = @"ePointRequest";
static NSString *const method_LatestBonusRequest = @"LatestBonusRequest"; //Dashboard
static NSString *const method_BonusSummary = @"BonusSummary";
static NSString *const method_ExclusiveStore = @"ExclusiveStore";
static NSString *const method_ProductListAll = @"productListAll";
static NSString *const method_GetMemberNameByID = @"getMemberNameById";
static NSString *const method_TransferEWallet = @"transferEwallet";
static NSString *const method_PaymentEaccount = @"PaymentEaccount";
static NSString *const method_PaymentEPoint = @"PaymentEpoint";
static NSString *const method_CurrencyRate = @"CurrencyRate";
static NSString *const method_PersonalProfileUpdate = @"PersonalProfileUpdate";
static NSString *const method_WithdrawMethod = @"WithdrawMethod";
static NSString *const method_WithdrawEwallet = @"WithdrawEwallet";
static NSString *const method_ResetPassword = @"ResetPassword";

//Mobile Sign Up
static NSString *const method_SignUpMemberInfo = @"SignUpMemberInfoJSON";
static NSString *const method_Nationality = @"Nationality";
static NSString *const method_RegisterType = @"RegisterType";
static NSString *const method_IDType = @"IdType";
static NSString *const method_Language = @"Language";
static NSString *const method_ZoneCode = @"ZoneCode";
static NSString *const method_DeliveryInfo = @"deliveryInfo";
static NSString *const method_updateDeliveryInfo = @"updateDeliveryInfo";
static NSString *const method_orderSummary = @"ordersummary";
static NSString *const method_checkAccountBalance = @"checkeaccountbalance";
static NSString *const method_paymentSuccess = @"PaymentSuccess";
static NSString *const method_ConfirmMemberInfo = @"ConfirmMemberInfo";
static NSString *const method_ProductInsert = @"ProductInsert";
static NSString *const method_CheckEPin = @"Check_epin";
static NSString *const method_CheckEAccountBalance = @"checkeaccountbalance";
static NSString *const method_wechatPaymentRequest = @"wechatPaymentRequest";
static NSString *const method_BankList = @"BankList";
static NSString *const method_BankStateList = @"StateList";

//New Join Method
static NSString *const method_Company = @"Company";
static NSString *const method_ShowCompany = @"ShowComp";
static NSString *const method_VerifyMember = @"Verify_member";
static NSString *const method_NewJoinSubmitForm = @"NewJoinSubmitForm";


@implementation RequestMgr

+ (id)shared
{
    static RequestMgr *mgr = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[self alloc]init];
    });
    
    return mgr;
}

#pragma mark - Requests

- (void)loginWithUsername:(NSString*)userName password:(NSString*)password completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *params = @{@"username":userName , @"password":password};
    
    NSString *loginURL = [[NSString stringWithFormat:@"%@?device=%@&version=%@",[self constructURLForMethod:method_Login],[[UIDevice currentDevice] modelName],version] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self showLoading];
    
    [manager POST:loginURL parameters:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        MCOLoginModel *model = (MCOLoginModel *)[self parseData:responseObject forClass:[MCOLoginModel class]];
        
        if (model.token.length && model.code.length)
        {
            [[LocalStorage shared] storeObject:model.token forKey:UserTokenKey];
            [[LocalStorage shared] storeObject:model.code forKey:UserNameKey];
        }
        else
        {
            NSLog(@"Missing token or Code");
        }
        
        
        if (completionBlock)
        {
            [self hideLoading];
            completionBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"Fail : %@" , error);
        [self hideLoading];
        if (failure)
        {
            failure(error);
        }
    }];            
}

- (void)requestPersonalSalesSubmissionFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"date_from" : fromDate , @"date_to" : toDate , @"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_PersonalSalesSubmission] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *personalSalesSubmissions = [self parseData:dataArray forClass:[MCOPersonalSalesSubmissionData class]];
        [[LocalStorage shared] setPersonalSalesSubmissions:[NSArray arrayWithArray:personalSalesSubmissions]];                
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Personal Sales Submission Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestAllSalesSubmissionFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"date_from" : fromDate , @"date_to" : toDate , @"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_AllSalesSubmission] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *allSalesSubmissions = [self parseData:dataArray forClass:[MCOAllSalesSubmissionModel class]];
        [[LocalStorage shared] setAllSalesSubmissions:[NSArray arrayWithArray:allSalesSubmissions]];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"All Sales Submission Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestEpointFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"date_from" : fromDate , @"date_to" : toDate , @"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_ePointRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"EPoint : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *ePoint = [self parseData:dataArray forClass:[MCOEpointListModel class]];
        
        [ePoint enumerateObjectsUsingBlock:^(MCOEpointListModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            obj.epoint = responseObject[@"epoint"];
        }];
        
        [[LocalStorage shared] setEPointLists:[NSArray arrayWithArray:ePoint]];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"All Sales Submission Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestEWalletFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"date_from" : fromDate , @"date_to" : toDate , @"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_EWalletRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Ewallet : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *eAccStatement = [self parseData:dataArray forClass:[MCOEAccStatementListModel class]];
        
        [eAccStatement enumerateObjectsUsingBlock:^(MCOEAccStatementListModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            obj.ewallet = responseObject[@"ewallet"];
        }];
        
        [[LocalStorage shared] setEAccStatementLists:[NSArray arrayWithArray:eAccStatement]];

        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"All Sales Submission Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestMemberInfo:(NSString *)code completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];

    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_MemberInfo] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        MCOMemberInfo *memberInfo = [self parseData:dataArray forClass:[MCOMemberInfo class]];
        
        if (completionBlock)
        {
            completionBlock(memberInfo);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)updateMemberInfo:(NSString *)memberID code:(NSString *)code completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];

    NSDictionary *params = @{@"id" : memberID , @"code" : code};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_MemberUpdateInfo] parameters:params progress:^(NSProgress * _Nonnull downloadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestAnnouncementListWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_AnnouncementList] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Announcement List Success : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *annoucementLists = [self parseData:dataArray forClass:[MCOAnnoucementListModel class]];
        [[LocalStorage shared] setAnnouncementLists:[NSArray arrayWithArray:annoucementLists]];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestAnnouncementListDetailsWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_AnnouncementListDetails] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Announcement List Details SUccess : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *annoucementListsDetail = [self parseData:dataArray forClass:[MCOAnnouncementListDetailModel class]];
        [[LocalStorage shared] setAnnouncementListsDetail:[NSArray arrayWithArray:annoucementListsDetail]];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];

}

/*
- (void)requestSalesListWithMemberInfo:(MCOMemberInfo *)info subType:(NSString *)subType completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];

    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"doc_subtype" : subType};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_SalesRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"Sales Request: %@",responseObject);
       
        NSString *dcTempNo = responseObject[@"data"];
        [[LocalStorage shared] setDcTempNo:dcTempNo];
        
        [self requestProductListMemberInfo:info dcTempNo:dcTempNo completionBlock:^(id response) {
            
            if (completionBlock)
            {
                completionBlock(response);
            }
        } failure:^(NSError *error)
        {

        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Sales Request Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
    
}
*/

- (void)requestProductListMemberInfo:(MCOMemberInfo *)info completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] ,
                             @"token" : [self token] ,
                             @"dc_temp_no" : [[LocalStorage shared] dcTempNo] ,
                             @"company" : info.f_company_code ,
                             @"price_code" : info.f_price_code};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_ProductListRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *placeOrder = [self parseData:dataArray forClass:[MCOPlaceOrderModel class]];
        [[LocalStorage shared] setProductLists:[NSArray arrayWithArray:placeOrder]];

        //NSLog(@"Product List Request : %@",dataArray);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestEpointWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_EPointRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Epoint Success : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestWalletWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_EWalletRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"EWallet Success : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestBonusWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_BonusRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Bonus Success : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestStateListCode:(NSString *)code completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"filter" : code , @"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_StateListCode] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"State list Success : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *stateList = [self parseData:dataArray forClass:[MCOStateList class]];
        [[LocalStorage shared] setStateLists:[NSArray arrayWithArray:stateList]];

        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestCountryListCodeWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_CountryList] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"Country list Success : %@" , responseObject);
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *countryList = [self parseData:dataArray forClass:[MCOCountryList class]];
        [[LocalStorage shared] setCountryLists:[NSArray arrayWithArray:countryList]];

        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)confirmMemberInfoWithTempUserID:(NSString *)tempUserID completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];

    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"temp_user_id" : tempUserID};
    
    [manager GET:[self constructSignUpURLForMethod:method_ConfirmMemberInfo] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"Confirm Member SUccess : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Confirm Member Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        
        [self hideLoading];
    }];
}

- (void)requestLatestBonusWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_LatestBonusRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Dashboard Success : %@" , responseObject);
        NSDictionary *dict = responseObject[@"data"];
        
        if (completionBlock)
        {
            completionBlock(dict);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestSalesBonusSummaryWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_BonusSummary] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Bonus Summary Success : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *bonusSummary = [self parseData:dataArray forClass:[MCOBonusSummaryModel class]];
        [[LocalStorage shared] setBonusSummaryList:bonusSummary];
        
        if (completionBlock)
        {
            completionBlock(dataArray);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestExclusiveStoreListWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"date_from" : @"2016-01-01" , @"date_to" : [NSDate todayDate]};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_ExclusiveStore] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Exclusive List Success : %@" , responseObject);
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *exclusiveStoreList = [self parseData:dataArray forClass:[MCOExclusiveStoreModel class]];
        
        NSMutableArray *level = [[NSMutableArray alloc] init];
        NSMutableArray *lists = [[NSMutableArray alloc] init];
        
        /*Not in order and remove duplicates from array*/
        //uniquearray = [yourarray valueForKeyPath:@"@distinctUnionOfObjects.self"];

        [exclusiveStoreList enumerateObjectsUsingBlock:^(MCOExclusiveStoreModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            [level addObject:obj.f_level];
        }];
        
        NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:level];
        level = [set mutableCopy];

        [level enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            
            [exclusiveStoreList enumerateObjectsUsingBlock:^(MCOExclusiveStoreModel* model, NSUInteger idx, BOOL * _Nonnull stop)
            {
                if ([model.f_level isEqualToString:obj])
                {
                    [tempArr addObject:model];
                }
            }];
            
            [lists addObject:tempArr];
        }];
        
        [[LocalStorage shared] setExclusiveStoreList:lists];
        
        if (completionBlock)
        {
            completionBlock(lists);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];

}


- (void)requestAllProductListWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"company" : @"MOI" , @"price_code" : @"DP"};

    [self showLoading];
    [manager GET:[self constructURLForMethod:method_ProductListAll] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *placeOrder = [self parseData:dataArray forClass:[MCOPlaceOrderModel class]];
        [[LocalStorage shared] setPreProductList:[NSArray arrayWithArray:placeOrder]];
        
        //NSLog(@"Product List Request : %@",dataArray);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)verifyMemberNameById:(NSString *)memberID completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];

    NSDictionary *params = @{@"username" : [self userName] , @"targetUserName" : memberID , @"token" : [self token]};
    
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_GetMemberNameByID] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)transferEwalletToMemberID:(NSString *)memberID
                           amount:(NSString *)amount
                          remarks:(NSString *)remarks
                             epin:(NSString *)epin
                  completionBlock:(void(^)(id response))completionBlock
                          failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{@"member_id" : memberID , @"amount" : amount , @"remarks" : remarks , @"epin" : epin};
    
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@",[self constructURLForMethod:method_TransferEWallet],[self userName],[self token]];

    [manager POST:postURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Transfer E Wallet Success : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"Transfer E Wallet Failed : %@" , error);
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
    
}


- (void)paymentEAccountWithEpin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    //NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"dc_temp_no" : [[LocalStorage shared] dcTempNo] , @"epin" : epin};
    
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@&dc_temp_no=%@&epin=%@",[self constructURLForMethod:method_PaymentEaccount],[self userName],[self token],[[LocalStorage shared] dcTempNo],epin];
    
    [manager POST:postURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Payment Eaccount Success : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"Payment Eaccount Failed : %@" , error);
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
}


- (void)paymentEPointWithEpin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    //NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"dc_temp_no" : [[LocalStorage shared] dcTempNo] , @"epin" : epin};
    
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@&dc_temp_no=%@&epin=%@",[self constructURLForMethod:method_PaymentEPoint],[self userName],[self token],[[LocalStorage shared] dcTempNo],epin];
    
    [manager POST:postURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Payment Epoint Success : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"Payment EPoint Failed : %@" , error);
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
}


- (void)requestWithdrawMethodWithAmount:(NSString *)amount completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@",[self constructURLForMethod:method_WithdrawMethod],[self userName],[self token]];

    NSDictionary *param = @{@"amount" : amount};

    [manager POST:postURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"WithDraw Method Success : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"WithDraw Method Failed : %@" , error);
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
}


- (void)submitWithdrawalRequest:(NSString *)amount withdrawalMethod:(NSString *)method epin:(NSString*)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];

    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@",[self constructURLForMethod:method_WithdrawEwallet],[self userName],[self token]];
    
    NSDictionary *param = @{@"amount" : amount,
                            @"withdraw_method" : method,
                            @"epin" :epin
                            };
    NSLog(@"PArams : %@",param);
    [manager POST:postURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"WithDraw Submit Success : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"WithDraw Submit Failed : %@" , error);
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
}


- (void)resetPassword:(NSString *)memberCode
                email:(NSString *)email
      completionBlock:(void(^)(id response))completionBlock
              failure:(void(^)(NSError *failure))failure;
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{@"f_code":[NSString checkEmptyParam:memberCode] ,
                             @"f_email":[NSString checkEmptyParam:email]};
    NSLog(@"Params : %@" , params);
    [manager POST:[self constructURLForMethod:method_ResetPassword] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Reset Password : %@" , responseObject);
        if (completionBlock) {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Reset Password Failed : %@" , error);
        if (failure) {
            failure(error);
        }
        [self hideLoading];
    }];
    
}


#pragma mark - Register New Member

- (void)requestCompanyCode:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSString *url = [NSString stringWithFormat:@"%@",[self constructNewJoinURLForMethod:method_Company]];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        
        NSMutableArray *companyNames = [[NSMutableArray alloc] initWithCapacity:dataArray.count];
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [companyNames addObject:obj[@"f_code"]];
        }];
        
        [[LocalStorage shared] setCompanyCode:companyNames];
        
        if (completionBlock) {
            completionBlock(responseObject);
        }
        [self hideLoading];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestSponsorCode:(BOOL)sponsor
                 sponsorID:(NSString *)sponsorID
           completionBlock:(void(^)(id response))completionBlock
                   failure:(void(^)(NSError* error))failure
{
 
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSString *url;
    NSDictionary *params = nil;

    if (!sponsor) {
        url = [NSString stringWithFormat:@"%@",[self constructNewJoinURLForMethod:method_ShowCompany]];
        
    }else {
        params =@{@"f_sponsor_code": [NSString checkEmptyParam:sponsorID]};
        url = [NSString stringWithFormat:@"%@",[self constructNewJoinURLForMethod:method_VerifyMember]];
    }
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MCOSponsor *sponsor = [self parseData:responseObject forClass:[MCOSponsor class]];
        [[LocalStorage shared] setSponsor:sponsor];
        
        if (completionBlock) {
            completionBlock(responseObject);
        }
        [self hideLoading];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)submitNewJoinForm:(SubmitNewJoinInfo *)info
          completionBlock:(void(^)(id response))completionBlock
                  failure:(void(^)(NSError *failure))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];

    NSString *url = [self constructNewJoinURLForMethod:method_NewJoinSubmitForm];
    
    NSDictionary *params = @{
                           @"f_company_code":[NSString checkEmptyParam:info.f_company_code],
                           @"f_sponsor_code":[NSString checkEmptyParam:info.f_sponsor_code],
                           @"f_nationality":[NSString checkEmptyParam:info.f_nationality],
                           @"f_name":[NSString checkEmptyParam:info.f_name],
                           @"f_email":[NSString checkEmptyParam:info.f_email],
                           @"f_idno":[NSString checkEmptyParam:info.f_idno],
                           @"f_mobile":[NSString checkEmptyParam:info.f_mobile],
                           @"f_mobile_code":[NSString checkEmptyParam:info.f_mobile_code],
                           @"f_password":[NSString checkEmptyParam:info.f_password],
                           };
    NSLog(@"Params : %@" , params);
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completionBlock) {
            completionBlock(responseObject);
        }
        [self hideLoading];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [self hideLoading];
    }];

}


#pragma mark - Profile

- (void)updateUserProfile:(MobileSignUpInfo *)info completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{
                             @"f_idno":[NSString checkEmptyParam:info.idNumber],
                             @"f_paypal_email":[NSString checkEmptyParam:info.paypalEmail],
                             @"f_paypal_nationality":[NSString checkEmptyParam:info.paypalNationality],
                             @"f_bank_paypal_name":[NSString checkEmptyParam:info.paypalAccountName],
                             @"f_bank_alipay_no":[NSString checkEmptyParam:info.alipayAccountNumber],
                             @"f_bank_alipay_name":[NSString checkEmptyParam:info.alipayAccountName],
                             @"f_bank_id":[NSString checkEmptyParam:info.chinaBank],
                             @"f_bank_account_name":[NSString checkEmptyParam:info.chinaBankAccountName],
                             @"f_bank_account_no":[NSString checkEmptyParam:info.chinaBankAccountNumber],
                             @"f_bank_account_owner_ic":[NSString checkEmptyParam:info.chinaBankAccountNIRC],
                             @"f_bank_state":[NSString checkEmptyParam:info.chinaBankState],
                             @"f_bank_city":[NSString checkEmptyParam:info.chinaBankDistrict],
                             @"f_bank_branch":[NSString checkEmptyParam:info.chinaBankBranch],
                             @"f_corr_address1":[NSString checkEmptyParam:info.corrAddress1],
                             @"f_corr_address2":[NSString checkEmptyParam:info.corrAddress2],
                             @"f_corr_address3":[NSString checkEmptyParam:info.corrAddress3],
                             @"f_corr_address4":[NSString checkEmptyParam:info.corrAddress4],
                             @"f_corr_postcode":[NSString checkEmptyParam:info.corrPostCode],
                             @"f_corr_mobile1":[NSString checkEmptyParam:info.corrMobile],
                             @"f_corr_email":[NSString checkEmptyParam:info.corrEmail],
                             @"f_corr_city":[NSString checkEmptyParam:info.corrCity],
                             @"f_corr_country":[NSString checkEmptyParam:info.corrCountry],
                             @"f_corr_state":[NSString checkEmptyParam:info.corrState],
                             @"f_ship_address1":[NSString checkEmptyParam:info.shipAddress1],
                             @"f_ship_address2":[NSString checkEmptyParam:info.shipAddress2],
                             @"f_ship_address3":[NSString checkEmptyParam:info.shipAddress3],
                             @"f_ship_address4":[NSString checkEmptyParam:info.shipAddress4],
                             @"f_ship_postcode":[NSString checkEmptyParam:info.shipPostCode],
                             @"f_ship_mobile1":[NSString checkEmptyParam:info.shipMobile],
                             @"f_ship_email":[NSString checkEmptyParam:info.shipEmail],
                             @"f_ship_city":[NSString checkEmptyParam:info.shipCity],
                             @"f_ship_country":[NSString checkEmptyParam:info.shipCountry],
                             @"f_ship_state":[NSString checkEmptyParam:info.shipState]
                             };
    NSLog(@"Params : %@" , params);
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@",[self constructURLForMethod:method_PersonalProfileUpdate],[self userName],[self token]];
    
    [manager POST:postURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
}


#pragma mark - Shipping

- (void)requestShippingAddressWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    [self showLoading];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"dc_temp_no" : [[LocalStorage shared] dcTempNo]};
    
    [manager GET:[self constructSignUpURLForMethod:method_DeliveryInfo] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *dataArray = responseObject[@"data"];
         NSMutableArray *shippingAddress = [self parseData:dataArray forClass:[MCOShippingAddressModel class]];
         NSLog(@"Shipping : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(shippingAddress);
        }

        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        
        [self hideLoading];
    }];
}


- (void)updateShippingAddressWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
     AFHTTPSessionManager *manager = [self sessionManager];
    
     [self showLoading];
    
     UpdateShippingAddressInfo *info = [[LocalStorage shared] shippingInfo];
    
     NSDictionary *params = @{@"f_address1" : [NSString checkEmptyParam:info.f_address_1] ,
                              @"f_address2" : [NSString checkEmptyParam:info.f_address_2] ,
                              @"f_address3" : [NSString checkEmptyParam:info.f_address_3] ,
                               @"f_contact" : [NSString checkEmptyParam:info.f_contact] ,
                              @"f_postcode" : [NSString checkEmptyParam:info.f_postcode] ,
                               @"f_country" : [NSString checkEmptyParam:info.f_country] ,
                                 @"f_state" : [NSString checkEmptyParam:info.f_state] ,
                                  @"f_city" : [NSString checkEmptyParam:info.f_city] ,
                                @"f_mobile1": [NSString checkEmptyParam:info.mobileNumber1],
                           @"f_mobile_code" : [NSString checkEmptyParam:info.mobileCode],
                                  @"f_idno" : [NSString checkEmptyParam:info.icNumber]};
    
    NSLog(@"Params Update : %@" , params);
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@&dc_temp_no=%@",[self constructSignUpURLForMethod:method_updateDeliveryInfo],[self userName],[self token],[NSString checkEmptyParam:[[LocalStorage shared] dcTempNo]]];
    
    [manager POST:postURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"Update Shipping Info Success : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"Failed Shipping Info Success : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


#pragma mark - Order Summary

- (void)getOrderSummaryWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"dc_temp_no" : [[LocalStorage shared] dcTempNo]};
    
    [manager GET:[self constructSignUpURLForMethod:method_orderSummary] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"Order Summary : %@" , responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Failed Order Summaray : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


#pragma mark - Check Account Balance

- (void)requestAccountBalanceWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    
    [manager GET:[self constructSignUpURLForMethod:method_checkAccountBalance] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [self hideLoading];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self hideLoading];
     }];

}


#pragma mark - Payment Success Request

- (void)updatePaymentStatusWithDocType:(NSString *)docType paymentType:(NSString *)paymentType transactionNo:(NSString *)transactionNo completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{@"username" : [self userName] ,
                             @"token" : [self token] ,
                             @"dc_temp_no" : [[LocalStorage shared] dcTempNo] ,
                             @"doc_subtype" : docType,
                             @"payment_type" : paymentType ,
                             @"trans_no" : transactionNo};
    
    [manager GET:[self constructSignUpURLForMethod:method_paymentSuccess] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"Payment Success : %@" , responseObject);
         if (completionBlock)
         {
             completionBlock(responseObject);
         }
         
         [self hideLoading];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"Failed Payment Success : %@" , error);
         
         if (failure)
         {
             failure(error);
         }
         [self hideLoading];
     }];
}



#pragma mark - Initialization

- (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager.responseSerializer setAcceptableContentTypes:[self defaultAcceptableContentTypes]];
    
    return manager;
}

#pragma mark - RegisterDistributorRequests

- (void)requestSalesRequestWithDocSubtype:(NSString *)docSubType completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token] , @"doc_subtype" : docSubType};
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_SalesRequest] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Sales Request: %@",responseObject);
        NSString *dcTempNo = responseObject[@"data"];
        [[LocalStorage shared] setDcTempNo:dcTempNo];
        
        if (completionBlock)
        {
            completionBlock(dcTempNo);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Sales Request Failed : %@" , error);
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestSignUpMemberInfo:(NSString *)dcTempNo signUpInfo:(MobileSignUpInfo *)info completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure;
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    /*
    NSDictionary *params = @{@"username" : [self userName] ,
                             @"token" : [self token] ,
                             @"dc_temp_no" : [NSString checkEmptyParam:dcTempNo] ,
                             @"f_nationality" : [NSString checkEmptyParam:info.nationality] ,
                             @"f_name" : [NSString checkEmptyParam:info.name] ,
                             @"f_id_type" : [NSString checkEmptyParam:info.idType] ,
                             @"f_idno" : [NSString checkEmptyParam:info.idNumber] ,
                             @"f_zone_code" : [NSString checkEmptyParam:info.zoneCode] ,
                             @"f_mobile1" : [NSString checkEmptyParam:info.mobile] ,
                             @"f_register_type" : [NSString checkEmptyParam:info.registerType] ,
                             @"f_date_of_birth" : [NSString checkEmptyParam:info.dateOfBirth] ,
                             @"f_preferred_language" : [NSString checkEmptyParam:info.preferredLanguage] ,
                             @"f_name" : [NSString checkEmptyParam:info.f_company_name],
                             @"f_idno" : [NSString checkEmptyParam:info.f_company_idNumber],
                             @"f_mobile" : [NSString checkEmptyParam:info.f_company_mobile],
                             @"f_paypal_nationality" : [NSString checkEmptyParam:info.paypalNationality],
                             @"f_paypal_email" : [NSString checkEmptyParam:info.paypalEmail]};
    */
    
    /*
    NSDictionary *params = @{@"username" : [self userName] ,
                             @"token" : [self token] ,
                             @"dc_temp_no" : [NSString checkEmptyParam:dcTempNo]};
     */
                             
    NSDictionary *emUserEntityParams = @{@"f_nationality" : [NSString checkEmptyParam:info.nationality],
                                              @"f_name" : [NSString checkEmptyParam:info.name],
                                              @"f_id_type" : [NSString checkEmptyParam:info.idType],
                                              @"f_idno" : [NSString checkEmptyParam:info.idNumber]};
    
    NSDictionary *emTerritoryParams = @{@"f_mobile_zone" : [NSString checkEmptyParam:info.mobileZone]};
    
    NSDictionary *emUserContactCorrParams = @{@"f_mobile1" : [NSString checkEmptyParam:info.mobile]};
    
    NSDictionary *emUserIdentityParams = @{@"f_register_type" : [NSString checkEmptyParam:info.registerType],
                                           @"f_date_of_birth" : [NSString checkEmptyParam:info.dateOfBirth] ,
                                      @"f_preferred_language" : [NSString checkEmptyParam:info.preferredLanguage]};
    
    NSDictionary *emUserDirectorParams = @{@"f_name" : [NSString checkEmptyParam:info.f_company_name],
                                     @"f_idno" : [NSString checkEmptyParam:info.f_company_idNumber],
                                     @"f_mobile" : [NSString checkEmptyParam:info.f_company_mobile]};
    
    NSDictionary *emUserAccountParams = @{@"f_paypal_nationality" : [NSString checkEmptyParam:info.paypalNationality],
                                          @"f_paypal_email" : [NSString checkEmptyParam:info.paypalEmail],
                                          @"f_bank_paypal_name" : [NSString checkEmptyParam:info.paypalAccountName],
                                          @"f_bank_alipay_no": [NSString checkEmptyParam:info.alipayAccountNumber],
                                          @"f_bank_alipay_name": [NSString checkEmptyParam:info.alipayAccountName],
                                          @"f_bank_id": [NSString checkEmptyParam:info.chinaBank],
                                          @"f_bank_account_name":[NSString checkEmptyParam:info.chinaBankAccountName],
                                          @"f_bank_account_no":[NSString checkEmptyParam:info.chinaBankAccountNumber],
                                          @"f_bank_account_owner_ic":[NSString checkEmptyParam:info.chinaBankAccountNIRC],
                                          @"f_bank_state":[NSString checkEmptyParam:info.chinaBankState],
                                          @"f_bank_branch":[NSString checkEmptyParam:info.chinaBankBranch],
                                          @"f_bank_city":[NSString checkEmptyParam:info.chinaBankDistrict]
                                          };
    
    
    NSDictionary *userEntityDict = @{@"EmUserEntity" : @[emUserEntityParams]};
    NSDictionary *territoryDict = @{@"EmTerritory" : @[emTerritoryParams]};
    NSDictionary *userContactCorrDict = @{@"EmUserContactCorr" : @[emUserContactCorrParams]};
    NSDictionary *userIdentityDict = @{@"EmUserIdentity" : @[emUserIdentityParams]};
    NSDictionary *userDirectorDict = @{@"EmUserDirector" : @[emUserDirectorParams]};
    NSDictionary *userAccountDict = @{@"EmUserAccount" : @[emUserAccountParams]};
    
    NSMutableDictionary *constructParams = [[NSMutableDictionary alloc] init];
    [constructParams addEntriesFromDictionary:userEntityDict];
    [constructParams addEntriesFromDictionary:territoryDict];
    [constructParams addEntriesFromDictionary:userContactCorrDict];
    [constructParams addEntriesFromDictionary:userIdentityDict];
    
    if (info.companyRegistration)
    {
        [constructParams addEntriesFromDictionary:userDirectorDict];
    }
    
    [constructParams addEntriesFromDictionary:userAccountDict];
    //[constructParams addEntriesFromDictionary:params];
    
    [self showLoading];
    
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@&dc_temp_no=%@",[self constructSignUpURLForMethod:method_SignUpMemberInfo],[self userName],[self token],[NSString checkEmptyParam:dcTempNo]];
    
    [manager POST:postURL parameters:constructParams progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"Response Object : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Failed : %@" , [error description]);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
    
}

- (void)requestNationalityCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName] , @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructSignUpURLForMethod:method_Nationality] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *nationalityArray = [self parseData:dataArray forClass:[MCONationalityModel class]];
        [[LocalStorage shared] setNationalities:nationalityArray];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Nationality Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestRegisterTypeCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructSignUpURLForMethod:method_RegisterType] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *registerTypeArray = [self parseData:dataArray forClass:[MCORegisterTypeModel class]];
        [[LocalStorage shared] setRegisterTypes:registerTypeArray];
        
        if (completionBlock)
        {
            completionBlock(nil);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Register Type Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestIDTypeCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructSignUpURLForMethod:method_IDType] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *idTypeArray = [self parseData:dataArray forClass:[MCOIDTypeModel class]];
        [[LocalStorage shared] setIdTypes:idTypeArray];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"ID Type Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestLanguageCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructSignUpURLForMethod:method_Language] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *languageArray = [self parseData:dataArray forClass:[MCOLanguageModel class]];
        [[LocalStorage shared] setLanguages:languageArray];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Language Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}

- (void)requestZoneCodeCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token]};
    [self showLoading];
    [manager GET:[self constructSignUpURLForMethod:method_ZoneCode] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *zoneCodeArray = [self parseData:dataArray forClass:[MCOZoneCodeModel class]];
        
        [zoneCodeArray enumerateObjectsUsingBlock:^(MCOZoneCodeModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            obj.zoneCodeWithState = [NSString stringWithFormat:@"%@ - %@",obj.f_mobile_zone,obj.f_description];
        }];
        
        [[LocalStorage shared] setZoneCodes:zoneCodeArray];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Zone Code Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestChinaBankListCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];

    [self showLoading];
    [manager GET:[self constructURLForMethod:method_BankList] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *chinaBankLists = [self parseData:dataArray forClass:[MCOChinaBankList class]];
        
        [[LocalStorage shared] setChinaBankLists:chinaBankLists];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Bank China List Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestChinaBankStateListCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    [self showLoading];
    [manager GET:[self constructURLForMethod:method_BankStateList] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *chinaBankStateLists = [self parseData:dataArray forClass:[MCOChinaBankStateList class]];
        
        [[LocalStorage shared] setChinaBankStateLists:chinaBankStateLists];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Bank China List Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)requestChinaBankDistrictListCompletionBlock:(NSString *)filterID
                                           response:(void(^)(id response))completionBlock
                                            failure:(void(^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    [self showLoading];
    
    NSString *url = [NSString stringWithFormat:@"%@?filter=%@",[self constructURLForMethod:method_BankStateList],filterID];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *chinaBankDistrictLists = [self parseData:dataArray forClass:[MCOChinaBankDistrictList class]];
        
        [[LocalStorage shared] setChinaBankDistrictLists:chinaBankDistrictLists];
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Bank China District Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)confirmPlaceOrderWithProducts:(NSArray *)products completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSString *postURL = [NSString stringWithFormat:@"%@?username=%@&token=%@&dc_temp_no=%@",[self constructSignUpURLForMethod:method_ProductInsert],[self userName],[self token],[[LocalStorage shared] dcTempNo]];
    [self showLoading];
    
    [manager POST:postURL parameters:products progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"Success Place Order : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Failed Place Order : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
        
    }];
}

- (void)checkEPin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token] , @"epin" : epin};
    [self showLoading];

    [manager GET:[self constructURLForMethod:method_CheckEPin] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Check Epin Success : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"EPin Code Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


- (void)checkEAccountBalanceCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token]};
    [self showLoading];
    
    [manager GET:[self constructURLForMethod:method_CheckEAccountBalance] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Check Eaccount Success : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Eaccount Code Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];
}


#pragma mark - Currency Rate

- (void)getCurrencyRate:(NSString *)currency completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    //http://admin.mcoceaninternational.com/index.php/api/mobile/CurrencyRate?currency=RMB
    
    AFHTTPSessionManager *manager = [self sessionManager];
    NSDictionary *params = @{@"currency" : currency};
    [self showLoading];
    
    [manager GET:[self constructURLForMethod:method_CurrencyRate] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Currency Success : %@" , responseObject);
        
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Currency Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        [self hideLoading];
    }];

}


#pragma mark - WeChat Payment Request

- (void)requestWeChatPaymentCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    [self showLoading];
    
    NSDictionary *params = @{@"username" : [self userName], @"token" : [self token] , @"dc_temp_no" : [[LocalStorage shared] dcTempNo]};
    
    [manager GET:[self constructSignUpURLForMethod:method_wechatPaymentRequest] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"WeChat Payment Response : %@" , responseObject);
        
        NSDictionary *data = responseObject[@"data"];
        MCOWeChatPayRequestModel *paymentRequest = (MCOWeChatPayRequestModel *)[self parseData:data forClass:[MCOWeChatPayRequestModel class]];
        
        if (completionBlock)
        {
            completionBlock(paymentRequest);
        }
        [self hideLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"WeChat payment Failed : %@" , error);
        
        if (failure)
        {
            failure(error);
        }
        
        [self hideLoading];
    }];


}


#pragma mark - Instance Method

- (NSString *)constructURLForMethod:(NSString *)method
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",baseURL,method];
    return urlString;
}

- (NSString *)constructSignUpURLForMethod:(NSString *)method
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",baseURLSignUp,method];
    return urlString;
}

- (NSString *)constructNewJoinURLForMethod:(NSString *)method
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",baseURLNewSignUp,method];
    return urlString;
}

- (NSSet *)defaultAcceptableContentTypes;
{
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
}


- (NSString *)userName
{
    NSString *username = [[LocalStorage shared] userName];
    return username;
}

- (NSString *)token
{
    NSString *token = [[LocalStorage shared] userToken];
    return token;
}

- (id)parseData:(id)data forClass:(Class)clazz
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    NSString *className = NSStringFromClass(clazz);
    id dataObject;
    
    NSError *error = nil;
    
    if ([data isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dictionary in data)
        {
            dataObject = [MTLJSONAdapter modelOfClass:NSClassFromString(className).class fromJSONDictionary:dictionary error:&error];
            [mutableArray addObject:dataObject];
        }
        
        if (error)
        {
            NSAssert(error, @"Should not be an error");
            NSLog(@"Error parsing data for Array : %@" , error);
        }
        
        return mutableArray;
    }
    else if ([data isKindOfClass:[NSDictionary class]])
    {
        dataObject = [MTLJSONAdapter modelOfClass:NSClassFromString(className).class fromJSONDictionary:data error:&error];
        
        if (error)
        {
            NSAssert(error, @"Should not be an error");
            NSLog(@"Error parsing data for Array : %@" , error);
        }
        
        return dataObject;
    }
    
    return nil;
}


#pragma mark - LCLoadingHUD

- (void)showLoading
{
    [LCLoadingHUD showLoading:NSLocalizedString(@"loading_text", "")];
}


- (void)hideLoading
{
    [LCLoadingHUD hideInKeyWindow];
}


@end
