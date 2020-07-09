//
//  MCOBonusSummaryModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOBonusSummaryModel.h"

@implementation MCOBonusSummaryModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"exclusiveProfit":@"exclusive_profit",
             @"retailProfit":@"f_bonus0",
             @"date":@"f_batch_no",
             @"totalBonus":@"f_total_bonus"
             };
}
@end
