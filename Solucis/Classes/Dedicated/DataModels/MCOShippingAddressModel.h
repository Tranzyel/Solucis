//
//  MCOShippingAddressModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-09-20.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOShippingAddressModel : MTLModel <MTLJSONSerializing>
@property (nonatomic , strong) NSString *f_address1;
@property (nonatomic , strong) NSString *f_address2;
@property (nonatomic , strong) NSString *f_address3;
@property (nonatomic , strong) NSString *f_address4;
@property (nonatomic , strong) NSString *f_city;
@property (nonatomic , strong) NSString *f_contact;
@property (nonatomic , strong) NSString *f_country;
@property (nonatomic , strong) NSString *f_fax;
@property (nonatomic , strong) NSString *f_fax2;
@property (nonatomic , strong) NSString *f_mobile1;
@property (nonatomic , strong) NSString *f_mobile2;
@property (nonatomic , strong) NSString *f_mobile_code;
@property (nonatomic , strong) NSString *f_postcode;
@property (nonatomic , strong) NSString *f_state;
@property (nonatomic , strong) NSString *f_street1;
@property (nonatomic , strong) NSString *f_street2;
@property (nonatomic , strong) NSString *f_tel_h;
@property (nonatomic , strong) NSString *f_tel_o;
@property (nonatomic , strong) NSString *f_tel_o2;
@property (nonatomic , strong) NSString *f_territory_id;
@property (nonatomic , strong) NSString *f_code;
@property (nonatomic , strong) NSString *country_id;
@property (nonatomic , strong) NSString *state_id;
@property (nonatomic , strong) NSString *f_idno;
@end
