//
//  MCOAnnoucementListModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-21.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOAnnoucementListModel.h"

@implementation MCOAnnoucementListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"startDate": @"start_date",
             @"endDate": @"end_date",
             @"f_id": @"f_id",
             @"f_title": @"f_title",
             @"f_detail" : @"f_detail"
             };
}

+(NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"dd-mm-YYYY";
    return dateFormatter;
}

+(NSValueTransformer *)startDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error)
            {
                
                return [[self dateFormatter] dateFromString:value];
                
            } reverseBlock:^id(NSDate *value, BOOL *success, NSError *__autoreleasing *error) {
                
                return [[self dateFormatter] stringFromDate:value];
                
            }];
}

+(NSValueTransformer *)endDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error)
            {
                
                return [[self dateFormatter] dateFromString:value];
                
            } reverseBlock:^id(NSDate *value, BOOL *success, NSError *__autoreleasing *error) {
                
                return [[self dateFormatter] stringFromDate:value];
                
            }];
}

@end
