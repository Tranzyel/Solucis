//
//  MCONationalityModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-19.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCONationalityModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *f_acc_limit;
@property (nonatomic, strong) NSString *f_active;
@property (nonatomic, strong) NSString *f_code;
@property (nonatomic, strong) NSString *f_company_code;
@property (nonatomic, strong) NSString *f_courier_link;
@property (nonatomic, strong) NSString *f_deleted;
@property (nonatomic, strong) NSString *f_description;
@property (nonatomic, strong) NSString *f_group;
@property (nonatomic, strong) NSString *f_handler;
@property (nonatomic, strong) NSString *f_id;
@property (nonatomic, strong) NSString *f_isparent;
@property (nonatomic, strong) NSString *f_left;
@property (nonatomic, strong) NSString *f_level;
@property (nonatomic, strong) NSString *f_parentid;
@property (nonatomic, strong) NSString *f_right;
@property (nonatomic, strong) NSString *f_seqno;
@property (nonatomic, strong) NSString *f_value;
@end
