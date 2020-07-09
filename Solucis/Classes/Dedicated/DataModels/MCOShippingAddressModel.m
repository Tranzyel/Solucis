//
//  MCOShippingAddressModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-20.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOShippingAddressModel.h"

@implementation MCOShippingAddressModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_address1":@"f_address1",
             @"f_address2":@"f_address2",
             @"f_address3":@"f_address3",
             @"f_address4":@"f_address4",
             @"f_city":@"f_city",
             @"f_contact":@"f_contact",
             @"f_country":@"f_country",
             @"f_fax":@"f_fax",
             @"f_fax2":@"f_fax2",
             @"f_mobile1":@"f_mobile1",
             @"f_mobile2":@"f_mobile2",
             @"f_mobile_code":@"f_mobile_code",
             @"f_postcode":@"f_postcode",
             @"f_state":@"f_state",
             @"f_street1":@"f_street1",
             @"f_street2":@"f_street2",
             @"f_tel_h":@"f_tel_h",
             @"f_tel_o":@"f_tel_o",
             @"f_tel_o2":@"f_tel_o2",
             @"f_territory_id":@"f_territory_id",
             @"f_code" : @"f_code",
             @"state_id" : @"state_id",
             @"country_id" : @"country_id",
             @"f_idno" : @"f_idno"
             };
}

@end
