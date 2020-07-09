//
//  MCOExclusiveStoreModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOExclusiveStoreModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSString *f_distributor_code;
@property (nonatomic, strong)NSString *f_distributor_id;
@property (nonatomic, strong)NSString *f_distributor_name;
@property (nonatomic, strong)NSString *f_joined_date;
@property (nonatomic, strong)NSString *f_level;
@property (nonatomic, strong)NSString *f_mobile1;
@property (nonatomic, strong)NSString *f_rank;
@property (nonatomic, strong)NSString *f_sponsor_code;
@property (nonatomic, strong)NSString *f_sponsor_name;

@end
