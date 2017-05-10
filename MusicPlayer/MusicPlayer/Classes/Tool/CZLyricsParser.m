//
//  CZLyricsParser.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "CZLyricsParser.h"
#import "CZLyrics.h"
#import "CZMusicTool.h"

@implementation CZLyricsParser

+ (NSArray *)lyricsArrWithMusic:(CZMusic *)music
{
    // 获取lrc文件url
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.lrc withExtension:nil];
    
    // 加载成字符串
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    // 分割, 依据\n, 分割成一行一行
    NSArray *lineArr = [string componentsSeparatedByString:@"\n"];// \在字符串中有转义的功能，是个特殊字符，如果想表示它本身:\\ 引号也是
    
    // 遍历每一行
   NSMutableArray *lyricsArrM = [NSMutableArray array];
    for (NSString *lineStr in lineArr) {
        // 每一行再匹配, 匹配出 时间-内容
        // [00:00.00]    \[\d{2}:\d{2}.\d{2}\]
        // d   0-9 代表任意数字
        // {2}   2个值
        NSString *pattern = @"\\[\\d{2}:\\d{2}.\\d{2}\\]";//转义2次 \\[ 转义成正则中的[ \\d -> d
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        
        // 匹配正则
        NSArray *timeResultArr = [regular matchesInString:lineStr options:0 range:NSMakeRange(0, lineStr.length)];
        
        // 取得歌词
        NSTextCheckingResult *lastResult = [timeResultArr lastObject];
        NSString *content = [lineStr substringFromIndex:(lastResult.range.length + lastResult.range.location)];
        
        // timeResultArr 应该是保存了 "时间" 对应NSTextCheckingResult
        for (NSTextCheckingResult *result in timeResultArr) {
            // 取出时间的字符串
            NSString *time = [lineStr substringWithRange:result.range];
            NSTimeInterval interval = [CZMusicTool timeIntervalWithString:time];
            
            // 创建模型
            CZLyrics *lyrics = [CZLyrics lyricsWithTime:interval content:content];
            [lyricsArrM addObject:lyrics];
        }
    }
//    NSLog(@"%@", lyricsArrM);
    
    // 给词组数组排序, 根据歌词时间从早到晚排序
    
    // 按照数组中每个元素的time属性进行比较排序(compare:), 升序,
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    // 给lyricsArr自己排序 (lyricsArr是个可变数组)
    [lyricsArrM sortUsingDescriptors:@[descriptor]];
    
    // 创建模型, 保存到数组内
    return [lyricsArrM copy];
}

@end



















