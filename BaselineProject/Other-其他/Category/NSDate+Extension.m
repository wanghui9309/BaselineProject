//
//  NSDate+Extension.m
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 判断某个时间是否处于当天内
 
 @param date 某个时间
 */
+ (BOOL)validateWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *expireDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    if ([date compare:startDate] == NSOrderedDescending && [date compare:expireDate] == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}

@end
