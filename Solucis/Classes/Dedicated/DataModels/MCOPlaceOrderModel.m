//
//  MCOPlaceOrderModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOPlaceOrderModel.h"

@implementation MCOPlaceOrderModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_is_promo": @"f_is_promo",
             @"f_products_type": @"f_products_type",
             @"f_unit_bv": @"f_unit_bv",
             @"f_unit_discount": @"f_unit_discount",
             @"f_unit_pv":@"f_unit_pv",
             @"f_unit_tax":@"f_unit_tax",
             @"image": @"image",
             @"name": @"name",
             @"products_aftax_price":@"products_aftax_price",
             @"products_id": @"products_id",
             @"products_weight": @"products_weight",
             @"sku":@"sku",
             @"products_short_description":@"products_short_description",
             @"products_description":@"products_description"
             };
}


@end
