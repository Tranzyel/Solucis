//
//  NSDate+DateRange.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "NSDate+DateRange.h"

#define DATE_FORMAT @"yyyy-MM-dd"

@implementation NSDate (DateRange)

+(void)dateFromRange:(DateRange)range dateFrom:(NSString **)dateFrom dateTo:(NSString **)dateTo;
{
    if (range == TodayDateRangeType)
    {
        [self todayDateRangeType:dateFrom dateTo:dateTo];
    }
    else if (range == YesterdayDateRangeType)
    {
        [self yesterdayDateRangeType:dateFrom dateTo:dateTo];
    }
    else if (range == Last7DaysDateRangeType)
    {
        [self last7DaysDateRangeType:dateFrom dateTo:dateTo];
    }
    else if (range == Last30DaysDateRangeType)
    {
        [self last30DaysDateRangeType:dateFrom dateTo:dateTo];
    }
    else if (range == ThisMonthDateRangeType)
    {
        [self thisMonthDateRangeType:dateFrom dateTo:dateTo];
    }
    else if (range == AllTimeDateRangeType)
    {
        [self allTimeDateRange:dateFrom dateTo:dateTo];
    }
    else if (range == LastMonthDateRangeType)
    {
        [self lastMonthDateRangeType:dateFrom dateTo:dateTo];
    }
}


+(void)todayDateRangeType:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    *dateFrom = [dateFormatter stringFromDate:[NSDate date]];
    *dateTo = [dateFormatter stringFromDate:[NSDate date]];
}

+(void)yesterdayDateRangeType:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.day   = -1;
    NSDate *yesterday = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    *dateFrom = [dateFormatter stringFromDate:yesterday];
    *dateTo = [dateFormatter stringFromDate:yesterday];
}

+(void)last7DaysDateRangeType:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.day   = -6;
    NSDate *last7Days = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    *dateFrom = [dateFormatter stringFromDate:last7Days];
    *dateTo = [dateFormatter stringFromDate:[NSDate date]];
}


+(void)last30DaysDateRangeType:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.day   = -29;
    NSDate *last30Days = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    *dateFrom = [dateFormatter stringFromDate:last30Days];
    *dateTo = [dateFormatter stringFromDate:[NSDate date]];
}

+ (void)thisMonthDateRangeType:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    *dateFrom = [dateFormatter stringFromDate:firstDayOfMonthDate];
    
    [comp setMonth:comp.month + 1];
    [comp setDay:0];
    NSDate *endDatOfMonthDate = [gregorian dateFromComponents:comp];
    *dateTo = [dateFormatter stringFromDate:endDatOfMonthDate];
}

+ (void)lastMonthDateRangeType:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    [comp setMonth:comp.month - 1];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    *dateFrom = [dateFormatter stringFromDate:firstDayOfMonthDate];
    
    [comp setMonth:comp.month + 1];
    [comp setDay:0];
    NSDate *endDatOfMonthDate = [gregorian dateFromComponents:comp];
    *dateTo = [dateFormatter stringFromDate:endDatOfMonthDate];
}

+ (void)allTimeDateRange:(NSString **)dateFrom dateTo:(NSString **)dateTo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    *dateFrom = @"2001-01-01";
    *dateTo = [dateFormatter stringFromDate:[NSDate date]];
    
}

+(NSString *)todayDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    
    return today;
}

@end
