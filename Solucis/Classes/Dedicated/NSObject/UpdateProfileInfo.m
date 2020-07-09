//
//  UpdateProfileInfo.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-23.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "UpdateProfileInfo.h"

@implementation UpdateProfileInfo

+(id)shared
{
    static UpdateProfileInfo *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

@end
