//
//  MCOZoneCodeModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-19.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOZoneCodeModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *f_code;
@property (nonatomic, strong) NSString *f_created_by;
@property (nonatomic, strong) NSString *f_created_on;
@property (nonatomic, strong) NSString *f_description;
@property (nonatomic, strong) NSString *f_id;
@property (nonatomic, strong) NSString *f_isparent;
@property (nonatomic, strong) NSString *f_left;
@property (nonatomic, strong) NSString *f_level;
@property (nonatomic, strong) NSString *f_location_id;
@property (nonatomic, strong) NSString *f_mobile_zone;
@property (nonatomic, strong) NSString *f_parentid;
@property (nonatomic, strong) NSString *f_right;
@property (nonatomic, strong) NSString *f_seqno;
@property (nonatomic, strong) NSString *f_status;
@property (nonatomic, strong) NSString *f_transfer;
@property (nonatomic, strong) NSString *f_type;
@property (nonatomic, strong) NSString *f_updated_by;
@property (nonatomic, strong) NSString *f_updated_on;
@property (nonatomic, strong) NSString *f_zone_code;
@property (nonatomic, strong) NSString *zoneCodeWithState;
@end
