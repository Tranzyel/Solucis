//
//  NSString+MCOcean.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "NSString+MCOcean.h"

@implementation NSString (MCOcean)

+ (NSString *)checkEmptyValue:(NSString *)value
{
    if (value.length == 0 || value == nil || [value isEqual:[NSNull null]])
    {
        value = @"-";
    }
    
    return value;
}

+ (NSString *)checkEmptyParam:(NSString *)value
{
    if (value.length == 0 || value == nil || [value isEqual:[NSNull null]])
    {
        value = @"";
    }
    
    return value;
}

@end
