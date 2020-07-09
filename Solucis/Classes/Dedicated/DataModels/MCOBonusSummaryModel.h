//
//  MCOBonusSummaryModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOBonusSummaryModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSString *retailProfit;
@property (nonatomic, strong)NSString *exclusiveProfit;
@property (nonatomic, strong)NSString *date;
@property (nonatomic, strong)NSString *totalBonus;
@end
