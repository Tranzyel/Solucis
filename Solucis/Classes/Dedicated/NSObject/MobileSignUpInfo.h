//
//  MobileSignUpInfo.h
//  Solucis
//
//  Created by Lam Si Mon on 16-09-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileSignUpInfo : NSObject

@property (nonatomic , strong) NSString *nationality;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *idType;
@property (nonatomic , strong) NSString *idNumber;
@property (nonatomic , strong) NSString *zoneCode;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *mobileZone;
@property (nonatomic , strong) NSString *registerType;
@property (nonatomic , strong) NSString *dateOfBirth;
@property (nonatomic , strong) NSString *preferredLanguage;
@property (nonatomic , strong) NSString *paypalNationality;
@property (nonatomic , strong) NSString *paypalEmail;

@property (nonatomic , strong) NSString *paypalAccountName;
@property (nonatomic , strong) NSString *alipayAccountNumber;
@property (nonatomic , strong) NSString *alipayAccountName;
@property (nonatomic , strong) NSString *chinaBank;
@property (nonatomic , strong) NSString *chinaBankAccountName;
@property (nonatomic , strong) NSString *chinaBankAccountNumber;
@property (nonatomic , strong) NSString *chinaBankAccountNIRC;
@property (nonatomic , strong) NSString *chinaBankState;
@property (nonatomic , strong) NSString *chinaBankDistrict;
@property (nonatomic , strong) NSString *chinaBankBranch;

@property (nonatomic , strong) NSString *f_company_name;
@property (nonatomic , strong) NSString *f_company_idNumber;
@property (nonatomic , strong) NSString *f_company_mobile;
@property (nonatomic , assign) BOOL companyRegistration;

@property (nonatomic , strong) NSString *corrAddress1;
@property (nonatomic , strong) NSString *corrAddress2;
@property (nonatomic , strong) NSString *corrAddress3;
@property (nonatomic , strong) NSString *corrAddress4;
@property (nonatomic , strong) NSString *corrPostCode;
@property (nonatomic , strong) NSString *corrMobile;
@property (nonatomic , strong) NSString *corrEmail;
@property (nonatomic , strong) NSString *corrCountry;
@property (nonatomic , strong) NSString *corrState;
@property (nonatomic , strong) NSString *corrBankDistrict;
@property (nonatomic , strong) NSString *corrCity;

@property (nonatomic , strong) NSString *shipAddress1;
@property (nonatomic , strong) NSString *shipAddress2;
@property (nonatomic , strong) NSString *shipAddress3;
@property (nonatomic , strong) NSString *shipAddress4;
@property (nonatomic , strong) NSString *shipPostCode;
@property (nonatomic , strong) NSString *shipMobile;
@property (nonatomic , strong) NSString *shipEmail;
@property (nonatomic , strong) NSString *shipCity;
@property (nonatomic , strong) NSString *shipCountry;
@property (nonatomic , strong) NSString *shipState;
@property (nonatomic , strong) NSString *shipBankBranch;
@property (nonatomic , strong) NSString *shipBankDistrict;


//Description
@property (nonatomic , strong) NSString *preferredLanguageDesc;
@property (nonatomic , strong) NSString *paypalNationalityDesc;
@end
