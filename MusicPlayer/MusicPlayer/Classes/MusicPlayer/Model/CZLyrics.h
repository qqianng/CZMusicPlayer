//
//  CZLyrics.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZLyrics : NSObject

+ (instancetype)lyricsWithTime:(NSTimeInterval)time content:(NSString *)content;

/**
 *  歌词内容
 */
@property (copy, nonatomic) NSString *content;
/**
 *  歌词显示的时间
 */
@property (assign, nonatomic) NSTimeInterval time;


@end
