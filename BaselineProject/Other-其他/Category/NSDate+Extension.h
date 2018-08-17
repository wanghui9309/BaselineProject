//
//  NSDate+Extension.h
//  BaselineProject
//
//  Created by WangHui on 2018/8/17.
//  Copyright © 2018年 WangHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 判断某个时间是否处于当天内
 
 @param date 某个时间
 */
+ (BOOL)validateWithDate:(NSDate *)date;

@end
