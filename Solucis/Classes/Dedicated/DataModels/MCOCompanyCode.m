//
//  MCOCompanyCode.m
//  Solucis
//
//  Created by Lam Si Mon on 18-09-04.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "MCOCompanyCode.h"

@implementation MCOCompanyCode
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"data": @"data",
             };
}
@end

@implementation MCOSponsor
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_sponsor_code": @"f_sponsor_code",
             @"f_sponsor_name":@"f_sponsor_name"             
             };
}
@end
