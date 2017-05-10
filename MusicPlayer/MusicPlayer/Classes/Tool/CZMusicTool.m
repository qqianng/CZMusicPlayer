//
//  CZMusicTool.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "CZMusicTool.h"

@implementation CZMusicTool

+ (NSString *)musicTimeWithTime:(NSTimeInterval)time
{
    // 利用NSDateFormatter来转换成1970:01:01-00:00:40
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];

    return [formatter stringFromDate:date];
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)str
{
    // [01:01.00] -> [00:00.00] 计算时间差
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"[mm:ss.SS]";
    NSDate *currenDate = [formatter dateFromString:str];
    NSDate *originalDete = [formatter dateFromString:@"[00:00.00]"];
    
    NSTimeInterval interval = [currenDate timeIntervalSinceDate:originalDete];
    return interval;
}

@end



















