//
//  MCOExclusiveStoreModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOExclusiveStoreModel.h"

@implementation MCOExclusiveStoreModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_distributor_code":@"f_distributor_code",
             @"f_distributor_id":@"f_distributor_id",
             @"f_distributor_name":@"f_distributor_name",
             @"f_joined_date":@"f_joined_date",
             @"f_level":@"f_level",
             @"f_mobile1":@"f_mobile1",
             @"f_rank":@"f_rank",
             @"f_sponsor_code":@"f_sponsor_code",
             @"f_sponsor_name":@"f_sponsor_name"
             };
}

@end
