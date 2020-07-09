//
//  MCOLanguageModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-19.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOLanguageModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *f_code;
@property (nonatomic, strong) NSString *f_description;

@end
