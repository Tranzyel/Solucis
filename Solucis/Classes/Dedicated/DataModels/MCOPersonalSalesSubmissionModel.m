//
//  PersonalSalesSubmissionModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-26.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOPersonalSalesSubmissionModel.h"
#import "MCOPersonalSalesSubmissionData.h"

@implementation MCOPersonalSalesSubmissionModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"status": @"status",
             @"count": @"count",
             @"msg": @"msg",
             @"data": @"data"
             };
}


+ (NSValueTransformer *)personalSalesSubmissionDataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MCOPersonalSalesSubmissionData class]];
}

@end
