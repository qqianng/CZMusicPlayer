//
//  CZMusicTool.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZMusicTool : NSObject

/**
 *  从时间戳转换成00:00格式的字符串
 */
+ (NSString *)musicTimeWithTime:(NSTimeInterval)time;

/**
 *  从[00:00.00]格式的字符串转换成时间戳
 */
+ (NSTimeInterval)timeIntervalWithString:(NSString *)str;

@end
