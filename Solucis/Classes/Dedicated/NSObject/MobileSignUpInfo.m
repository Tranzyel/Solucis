//
//  MobileSignUpInfo.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MobileSignUpInfo.h"

@implementation MobileSignUpInfo
+(id)shared
{
    static MobileSignUpInfo *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

@end
