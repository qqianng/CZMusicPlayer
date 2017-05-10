//
//  CZLyrics.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "CZLyrics.h"

@implementation CZLyrics

+ (instancetype)lyricsWithTime:(NSTimeInterval)time content:(NSString *)content
{
    CZLyrics *lyrices = [[CZLyrics alloc] init];
    lyrices.content = content;
    lyrices.time = time;
    
    return lyrices;
}

@end
