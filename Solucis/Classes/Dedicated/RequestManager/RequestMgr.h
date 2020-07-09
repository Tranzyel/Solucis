//
//  RequestMgr.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCOMemberInfo;
@class MobileSignUpInfo;
@class SubmitNewJoinInfo;

@interface RequestMgr : NSObject
+ (id)shared;

- (id)parseData:(id)data forClass:(Class)clazz;

- (void)loginWithUsername:(NSString*)userName password:(NSString*)password completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestPersonalSalesSubmissionFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestAllSalesSubmissionFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestEpointFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestEWalletFromDate:(NSString *)fromDate toDate:(NSString *)toDate completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestMemberInfo:(NSString *)code completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)updateMemberInfo:(NSString *)memberID code:(NSString *)code completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestAnnouncementListWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestAnnouncementListDetailsWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

//- (void)requestSalesListWithMemberInfo:(MCOMemberInfo *)info subType:(NSString *)subType completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;
- (void)requestProductListMemberInfo:(MCOMemberInfo *)info completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestBonusWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestWalletWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestEpointWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestStateListCode:(NSString *)code completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestCountryListCodeWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestLatestBonusWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestAllProductListWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestShippingAddressWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)updateShippingAddressWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)getOrderSummaryWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestAccountBalanceWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)updatePaymentStatusWithDocType:(NSString *)docType paymentType:(NSString *)paymentType transactionNo:(NSString *)transactionNo completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)verifyMemberNameById:(NSString *)memberID completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)transferEwalletToMemberID:(NSString *)memberID amount:(NSString *)amount remarks:(NSString *)remarks epin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)paymentEAccountWithEpin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)paymentEPointWithEpin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)getCurrencyRate:(NSString *)currency completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestChinaBankListCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)requestChinaBankStateListCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)requestChinaBankDistrictListCompletionBlock:(NSString *)filterID
                                           response:(void(^)(id response))completionBlock
                                            failure:(void(^)(NSError *))failure;

- (void)updateUserProfile:(MobileSignUpInfo *)info completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure;

- (void)requestWithdrawMethodWithAmount:(NSString *)amount completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure;

- (void)submitWithdrawalRequest:(NSString *)amount withdrawalMethod:(NSString *)method epin:(NSString*)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure;

- (void)resetPassword:(NSString *)memberCode
                email:(NSString *)email
      completionBlock:(void(^)(id response))completionBlock
              failure:(void(^)(NSError *failure))failure;

//Register Distributor
- (void)requestSalesBonusSummaryWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestSignUpMemberInfo:(NSString *)dcTempNo signUpInfo:(MobileSignUpInfo *)info completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *failure))failure;

- (void)requestExclusiveStoreListWithCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestSalesRequestWithDocSubtype:(NSString *)docSubType completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)requestNationalityCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)requestRegisterTypeCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)requestIDTypeCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)requestLanguageCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)requestZoneCodeCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *))failure;

- (void)confirmMemberInfoWithTempUserID:(NSString *)tempUserID completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)confirmPlaceOrderWithProducts:(NSArray *)products completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)checkEPin:(NSString *)epin completionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

- (void)checkEAccountBalanceCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

#pragma mark - New Join Member
- (void)requestCompanyCode:(void(^)(id response))completionBlock failure:(void(^)(NSError* error))failure;

- (void)requestSponsorCode:(BOOL)sponsor
                 sponsorID:(NSString *)sponsorID
           completionBlock:(void(^)(id response))completionBlock
                   failure:(void(^)(NSError* error))failure;

- (void)submitNewJoinForm:(SubmitNewJoinInfo *)info
          completionBlock:(void(^)(id response))completionBlock
                  failure:(void(^)(NSError *failure))failure;

//Loading
- (void)showLoading;
- (void)hideLoading;

//WeChat Request
- (void)requestWeChatPaymentCompletionBlock:(void(^)(id response))completionBlock failure:(void(^)(NSError *error))failure;

@end

