//
//  CZLyricsParser.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZMusic.h"

@interface CZLyricsParser : NSObject

/**
 *  根据music模型的lrc文件名, 将其转换成WordLyrics模型的数组
 */
+ (NSArray *)lyricsArrWithMusic:(CZMusic *)music;

@end
