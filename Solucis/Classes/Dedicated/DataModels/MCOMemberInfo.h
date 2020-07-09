//
//  MCOMemberInfo.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-05.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOMemberInfo : MTLModel <MTLJSONSerializing>

@property(nonatomic, strong)NSString *f_sponsor_code;
@property(nonatomic, strong)NSString *f_sponsor_name;
@property(nonatomic, strong)NSString *f_name;
@property(nonatomic, strong)NSString *f_code;
@property(nonatomic, strong)NSString *rank_desc;
@property(nonatomic, strong)NSString *f_company_code;
@property(nonatomic, strong)NSString *f_price_code;
@property(nonatomic, strong)NSString *f_corr_address1;
@property(nonatomic, strong)NSString *f_corr_address2;
@property(nonatomic, strong)NSString *f_corr_address3;
@property(nonatomic, strong)NSString *f_corr_address4;
@property(nonatomic, strong)NSString *f_corr_city;
@property(nonatomic, strong)NSString *f_corr_mobile1;
@property(nonatomic, strong)NSString *f_corr_mobile_code;
@property(nonatomic, strong)NSString *f_corr_state;
@property(nonatomic, strong)NSString *f_corr_country;

@property(nonatomic, strong)NSString *f_corr_postcode;
@property(nonatomic, strong)NSString *f_nationality;

@property(nonatomic, strong)NSString *f_ship_contact;
@property(nonatomic, strong)NSString *f_ship_address1;
@property(nonatomic, strong)NSString *f_ship_address2;
@property(nonatomic, strong)NSString *f_ship_address3;
@property(nonatomic, strong)NSString *f_ship_address4;
@property(nonatomic, strong)NSString *f_ship_postcode;
@property(nonatomic, strong)NSString *f_ship_city;
@property(nonatomic, strong)NSString *f_ship_state;
@property(nonatomic, strong)NSString *f_ship_country;
@property(nonatomic, strong)NSString *f_ship_mobile_code;
@property(nonatomic, strong)NSString *f_ship_mobile1;
@property(nonatomic, strong)NSString *f_ship_email;


@property(nonatomic, strong)NSString *f_bank_account_name;
@property(nonatomic, strong)NSString *f_bank_account_no;
@property(nonatomic, strong)NSString *f_bank_account_owner_ic;

@property(nonatomic, strong)NSString *f_bank_alipay_name;
@property(nonatomic, strong)NSString *f_bank_alipay_no;

@property(nonatomic, strong)NSString *f_bank_branch;
@property(nonatomic, strong)NSString *f_bank_city;
@property(nonatomic, strong)NSString *f_bank_id;
@property(nonatomic, strong)NSString *f_bank_state;


@property(nonatomic, strong)NSString *f_corr_email;

@property(nonatomic, strong)NSString *f_paypal_nationality;
@property(nonatomic, strong)NSString *f_paypal_email;
@property(nonatomic, strong)NSString *f_corr_tel_h;
@property(nonatomic, strong)NSString *f_corr_tel_o;
@property(nonatomic, strong)NSString *f_joined_date;
@property(nonatomic, strong)NSString *f_bank_paypal_name;

@property(nonatomic, strong)NSString *f_idno;
@property(nonatomic, strong)NSString *f_status;
@property(nonatomic, strong)NSString *f_corr_fax;
@end
