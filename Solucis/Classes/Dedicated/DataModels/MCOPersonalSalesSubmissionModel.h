//
//  PersonalSalesSubmissionModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-26.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCOPersonalSalesSubmissionData;
@interface MCOPersonalSalesSubmissionModel : MTLModel <MTLJSONSerializing>

@property(nonatomic, strong) NSString * status;
@property(nonatomic, strong) NSString * count;
@property(nonatomic, strong) NSString * msg;
@property(nonatomic, strong) NSArray *data;
@property(nonatomic, strong) MCOPersonalSalesSubmissionData *personalSalesSubmissionData;

@end
