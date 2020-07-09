//
//  MCONationalityModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-19.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCONationalityModel.h"

@implementation MCONationalityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_acc_limit":@"f_acc_limit",
             @"f_active":@"f_active",
             @"f_code":@"f_code",
             @"f_company_code":@"f_company_code",
             @"f_courier_link":@"f_courier_link",
             @"f_deleted":@"f_deleted",
             @"f_description":@"f_description",
             @"f_group":@"f_description",
             @"f_handler":@"f_handler",
             @"f_id":@"f_id",
             @"f_isparent":@"f_isparent",
             @"f_left":@"f_left",
             @"f_level":@"f_level",
             @"f_parentid":@"f_parentid",
             @"f_right":@"f_right",
             @"f_seqno":@"f_seqno",
             @"f_value":@"f_value"
             };
}

@end
