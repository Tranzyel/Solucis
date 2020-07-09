//
//  MCOStateList.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOStateList.h"

@implementation MCOStateList
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_code": @"f_code",
             @"f_description":@"f_description",
             @"f_id":@"f_id"
             };
}
@end

@implementation MCOCorrStateList
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_code": @"f_code",
             @"f_description":@"f_description",
             @"f_id":@"f_id"
             };
}
@end

@implementation MCOShipStateList
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_code": @"f_code",
             @"f_description":@"f_description",
             @"f_id":@"f_id"
             };
}
@end
