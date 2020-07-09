//
//  MCOLoginModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-26.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOLoginModel.h"

@implementation MCOLoginModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code": @"code",
             @"msg": @"msg",
             @"status": @"status",
             @"token": @"token"
             };
}

@end
