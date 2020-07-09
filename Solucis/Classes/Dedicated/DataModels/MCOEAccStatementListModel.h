//
//  MCOEAccStatementListModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOEAccStatementListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSString *f_company_code;
@property (nonatomic, strong)NSString *f_credit;
@property (nonatomic, strong)NSString *f_debit;
@property (nonatomic, strong)NSString *f_doc_id;
@property (nonatomic, strong)NSString *f_doc_no;
@property (nonatomic, strong)NSString *f_doc_type;
@property (nonatomic, strong)NSString *f_eacc_bal;
@property (nonatomic, strong)NSString *f_eacc_type;
@property (nonatomic, strong)NSString *f_remark;
@property (nonatomic, strong)NSString *f_trans_date;
@property (nonatomic, strong)NSString *ewallet;
@end
