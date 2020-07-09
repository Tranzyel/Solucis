//
//  UpdateProfileInfo.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-23.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateProfileInfo : NSObject
@property (nonatomic , strong) NSString *memberICNumber;

@property (nonatomic , strong) NSString *paypalNationality;
@property (nonatomic , strong) NSString *paypalEmail;
@property (nonatomic , strong) NSString *paypalAccountName;

@property (nonatomic , strong) NSString *aliPayAccNumber;
@property (nonatomic , strong) NSString *aliPayAccName;

@property (nonatomic , strong) NSString *chinaBank;
@property (nonatomic , strong) NSString *bankAccountName;
@property (nonatomic , strong) NSString *bankAccountNIRC;
@property (nonatomic , strong) NSString *bankAccountNumber;
@property (nonatomic , strong) NSString *chinaBankState;
@property (nonatomic , strong) NSString *chinaBankDistrict;
@property (nonatomic , strong) NSString *chinaBankBranch;

@property (nonatomic , strong) NSString *corrAddress1;
@property (nonatomic , strong) NSString *corrAddress2;
@property (nonatomic , strong) NSString *corrAddress3;
@property (nonatomic , strong) NSString *corrAddress4;
@property (nonatomic , strong) NSString *corrPostCode;
@property (nonatomic , strong) NSString *corrCountryCode;
@property (nonatomic , strong) NSString *corrMobileNumber;
@property (nonatomic , strong) NSString *corrCountry;
@property (nonatomic , strong) NSString *corrState;
@property (nonatomic , strong) NSString *corrEmail;
@property (nonatomic , strong) NSString *corrCity;

@property (nonatomic , strong) NSString *shipAddress1;
@property (nonatomic , strong) NSString *shipAddress2;
@property (nonatomic , strong) NSString *shipAddress3;
@property (nonatomic , strong) NSString *shipAddress4;
@property (nonatomic , strong) NSString *shipPostCode;
@property (nonatomic , strong) NSString *shipCountryCode;
@property (nonatomic , strong) NSString *shipMobileNumber;
@property (nonatomic , strong) NSString *shipCountry;
@property (nonatomic , strong) NSString *shipState;
@property (nonatomic , strong) NSString *shipEmail;
@property (nonatomic , strong) NSString *shipCity;

@end
