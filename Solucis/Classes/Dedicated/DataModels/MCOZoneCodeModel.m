//
//  MCOZoneCodeModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-19.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOZoneCodeModel.h"

@implementation MCOZoneCodeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_code":@"f_code",
             @"f_created_by":@"f_created_by",
             @"f_created_on":@"f_created_on",
             @"f_description":@"f_description",
             @"f_id":@"f_id",
             @"f_isparent":@"f_isparent",
             @"f_left":@"f_left",
             @"f_level":@"f_level",
             @"f_location_id":@"f_location_id",
             @"f_mobile_zone":@"f_mobile_zone",
             @"f_parentid":@"f_parentid",
             @"f_right":@"f_right",
             @"f_seqno":@"f_seqno",
             @"f_status":@"f_status",
             @"f_transfer":@"f_transfer",
             @"f_type":@"f_type",
             @"f_updated_by":@"f_updated_by",
             @"f_updated_on":@"f_updated_on",
             @"f_zone_code":@"f_zone_code",
             };
}


@end
