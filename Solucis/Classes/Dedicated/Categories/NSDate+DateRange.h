//
//  NSDate+DateRange.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateRange)
+(void)dateFromRange:(DateRange)rangeType dateFrom:(NSString **)dateFrom dateTo:(NSString **)dateTo;
+(NSString *)todayDate;
@end
