//
//  MCOCompanyCode.h
//  Solucis
//
//  Created by Lam Si Mon on 18-09-04.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOCompanyCode : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSArray *data;
@end

@interface MCOSponsor : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *f_sponsor_code;
@property (nonatomic, strong) NSString *f_sponsor_name;
@end
