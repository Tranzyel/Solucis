//
//  LocalStorage.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-21.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCOMemberInfo;
@class UpdateShippingAddressInfo;
@class MCOShippingAddressModel;
@class MobileSignUpInfo;
@class MCOSponsor;

@interface LocalStorage : NSObject

+(id)shared;
@property(nonatomic, strong) NSArray *announcementLists;
@property(nonatomic, strong) NSArray *announcementListsDetail;
@property(nonatomic, strong) NSArray *personalSalesSubmissions;
@property(nonatomic, strong) NSArray *allSalesSubmissions;
@property(nonatomic, strong) NSArray *productLists;
@property(nonatomic, strong) NSArray *stateLists;
@property(nonatomic, strong) NSArray *corrStateLists;
@property(nonatomic, strong) NSArray *shipStateLists;
@property(nonatomic, strong) NSArray *countryLists;
@property(nonatomic, strong) NSArray *ePointLists;
@property(nonatomic, strong) NSArray *eAccStatementLists;
@property(nonatomic, strong) NSArray *bonusSummaryList;
@property(nonatomic, strong) NSArray *exclusiveStoreList;
@property(nonatomic, strong) NSArray *preProductList;

@property(nonatomic, strong) NSString *userToken;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) MCOMemberInfo *memberInfo;
@property(nonatomic, assign) BOOL loggedIn;

//Register Distributor Options
@property(nonatomic, strong) NSArray *nationalities;
@property(nonatomic, strong) NSArray *registerTypes;
@property(nonatomic, strong) NSArray *idTypes;
@property(nonatomic, strong) NSArray *languages;
@property(nonatomic, strong) NSArray *zoneCodes;
@property(nonatomic, strong) NSArray *chinaBankLists;
@property(nonatomic, strong) NSArray *chinaBankStateLists;
@property(nonatomic, strong) NSArray *chinaBankDistrictLists;
@property(nonatomic, strong) MobileSignUpInfo *signUpInfo;

//New Join
@property(nonatomic, strong) NSArray *companyCode;
@property(nonatomic, strong) MCOSponsor *sponsor;

- (void)storeObject:(id)object forKey:(NSString *)key;
- (id)getUserDefaultsObjectForKey:(NSString *)key;

- (NSArray<NSString*> *)filteredCountryList;
- (NSArray<NSString*> *)filteredStateList;
- (NSArray<NSString*> *)filteredCorrStateList;
- (NSArray<NSString*> *)filteredShipStateList;
- (NSArray<NSString*> *)filteredNationalities;
- (NSArray<NSString*> *)filteredRegisteredType;
- (NSArray<NSString*> *)filteredLanguages;
- (NSArray<NSString*> *)filteredZoneCodes;
- (NSArray<NSString*> *)filteredPaypalZoneCodes;
- (NSArray<NSString*> *)filteredIDTypes;
- (NSArray<NSString*> *)filteredChinaBankLists;
- (NSArray<NSString*> *)filteredChinaBankStateLists;
- (NSArray<NSString*> *)filteredChinaBankDistrictLists;
- (NSString *)currentLanguage;
- (NSString *)selectedLanguageText;

//TempData
@property (nonatomic, strong)NSArray *tempPlaceOrderArray;
@property (nonatomic, strong)NSString *dcTempNo;
@property (assign)float totalPurchasedIncGST;
@property (assign)float totalDeliveryCharges;
@property (assign)float subTotalAmount;

//Shipping Info
@property (nonatomic , strong) UpdateShippingAddressInfo *shippingInfo;
@property (nonatomic , strong) MCOShippingAddressModel *shippingAddress;

//WeChat Payment Request
//@property (nonatomic , strong)

@end

static NSString *const UserTokenKey = @"UserTokenUserDefaults";
static NSString *const UserNameKey = @"UserNameUserDefaults";
