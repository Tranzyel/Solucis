//
//  MCOEAccStatementListModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOEAccStatementListModel.h"

@implementation MCOEAccStatementListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"f_company_code": @"f_company_code",
             @"f_credit": @"f_credit",
             @"f_debit": @"f_debit",
             @"f_doc_id": @"f_doc_id",
             @"f_doc_no": @"f_doc_no",
             @"f_doc_type": @"f_doc_type",
             @"f_eacc_bal": @"f_eacc_bal",
             @"f_eacc_type": @"f_eacc_type",
             @"f_remark": @"f_remark",
             @"f_trans_date":@"f_trans_date",
             @"ewallet":@"ewallet"
             };
}
@end
