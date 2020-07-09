//
//  DateRange.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#ifndef DateRange_h
#define DateRange_h

typedef NS_ENUM(NSUInteger,DateRange)
{
    TodayDateRangeType = 0,
    YesterdayDateRangeType,
    Last7DaysDateRangeType,
    Last30DaysDateRangeType,
    ThisMonthDateRangeType,
    LastMonthDateRangeType,
    AllTimeDateRangeType
};
#endif /* DateRange_h */
