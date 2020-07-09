//
//  MCOChinaBankDistrictList.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-18.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOChinaBankDistrictList : MTLModel <MTLJSONSerializing>
@property (nonatomic , strong) NSString *f_id;
@property (nonatomic , strong) NSString *f_description;
@end
