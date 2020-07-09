//
//  MCOAllSalesSubmissionModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOAllSalesSubmissionModel.h"

@implementation MCOAllSalesSubmissionModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"created_name": @"created_name",
             @"f_check_code": @"f_check_code",
             @"f_code": @"f_code",
             @"f_created_by": @"f_created_by",
             @"f_created_on": @"f_created_on",
             @"f_doc_date":@"f_doc_date",
             @"f_doc_no":@"f_doc_no",
             @"f_id": @"f_id",
             @"f_name":@"f_name",
             @"f_operation_code":@"f_operation_code",
             @"f_operation_from": @"f_operation_from",
             @"f_operation_name":@"f_operation_name",
             @"f_ref_no":@"f_ref_no",
             @"f_status":@"f_status",
             @"f_total_amount":@"f_total_amount",
             @"f_total_bv":@"f_total_bv",
             @"f_total_pv":@"f_total_pv",
             @"f_user_id":@"f_user_id"
             };
}

@end
