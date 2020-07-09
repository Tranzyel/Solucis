//
//  UpdateShippingAddressInfo.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-20.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "UpdateShippingAddressInfo.h"

@implementation UpdateShippingAddressInfo

+ (id)shared
{
    static UpdateShippingAddressInfo *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

@end
