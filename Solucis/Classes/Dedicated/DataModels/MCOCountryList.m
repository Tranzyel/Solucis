//
//  MCOCountryList.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOCountryList.h"

@implementation MCOCountryList
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_code": @"f_code",
             @"f_description":@"f_description",
             @"f_id":@"f_id"
             };
}
@end
