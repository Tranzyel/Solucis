//
//  MCOStateList.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOStateList : MTLModel <MTLJSONSerializing>
@property(nonatomic, strong)NSString *f_code;
@property(nonatomic, strong)NSString *f_description;
@property(nonatomic, strong)NSString *f_id;
@end

@interface MCOCorrStateList : MTLModel <MTLJSONSerializing>
@property(nonatomic, strong)NSString *f_code;
@property(nonatomic, strong)NSString *f_description;
@property(nonatomic, strong)NSString *f_id;
@end

@interface MCOShipStateList : MTLModel <MTLJSONSerializing>
@property(nonatomic, strong)NSString *f_code;
@property(nonatomic, strong)NSString *f_description;
@property(nonatomic, strong)NSString *f_id;
@end
