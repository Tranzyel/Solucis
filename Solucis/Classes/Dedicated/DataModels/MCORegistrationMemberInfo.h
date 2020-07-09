//
//  MCORegistrationMemberInfo.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-19.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCORegistrationMemberInfo : NSObject

@property (nonatomic ,strong) NSString *nationality;
@property (nonatomic ,strong) NSString *memberName;
@property (nonatomic ,strong) NSString *idType;
@property (nonatomic ,strong) NSString *idNo;
@property (nonatomic ,strong) NSString *zoneCode;
@property (nonatomic ,strong) NSString *mobile;
@property (nonatomic ,strong) NSString *registerType;
@property (nonatomic ,strong) NSString *dateOfBirth; //yyyy-mm-dd
@property (nonatomic ,strong) NSString *preferredLanguage;
@property (nonatomic ,strong) NSString *companyName;
@property (nonatomic ,strong) NSString *companyIDNo;
@property (nonatomic ,strong) NSString *companyMobile;
@property (nonatomic ,strong) NSString *payPalNationality;
@property (nonatomic ,strong) NSString *paypalEmail;

@end
