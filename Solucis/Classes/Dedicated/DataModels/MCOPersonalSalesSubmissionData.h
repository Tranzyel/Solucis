//
//  MCOPersonalSalesSubmissionData.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOPersonalSalesSubmissionData : MTLModel <MTLJSONSerializing>

@property(nonatomic, strong) NSString * f_id;
@property(nonatomic, strong) NSString * f_doc_no;
@property(nonatomic, strong) NSString * f_doc_subtype;
@property(nonatomic, strong) NSString * f_doc_date;
@property(nonatomic, strong) NSString * f_company_code;
@property(nonatomic, strong) NSString * f_status;
@property(nonatomic, strong) NSString * f_check_code;
@property(nonatomic, strong) NSString * f_created_on;
@property(nonatomic, strong) NSString * f_created_by;
@property(nonatomic, strong) NSString * f_ref_no;
@property(nonatomic, strong) NSString * created_name;
@property(nonatomic, strong) NSString * f_operation_from;
@property(nonatomic, strong) NSString * f_user_id;
@property(nonatomic, strong) NSString * f_total_pv;
@property(nonatomic, strong) NSString * f_total_bv;
@property(nonatomic, strong) NSString * f_total_amount;
@property(nonatomic, strong) NSString * f_code;
@property(nonatomic, strong) NSString * f_name;
@property(nonatomic, strong) NSString * f_operation_code;
@property(nonatomic, strong) NSString * f_oeration_name;
@property(nonatomic, strong) NSString * f_do_no;
@property(nonatomic, strong) NSString * f_consignment;
@property(nonatomic, strong) NSString * f_consignment_date;

@end
