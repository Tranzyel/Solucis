//
//  MCOLoginModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-26.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOLoginModel : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy, readonly) NSString *code;
@property(nonatomic, copy, readonly) NSString *msg;
@property(nonatomic, copy, readonly) NSNumber *status;
@property(nonatomic, copy, readonly) NSString *token;

@end
