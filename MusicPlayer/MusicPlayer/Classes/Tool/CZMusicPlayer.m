//
//  CZMusicPlayer.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

/**
 *  不做缓存,  简单的单例
 */

#import "CZMusicPlayer.h"

@interface CZMusicPlayer ()

@property (strong, nonatomic) AVAudioPlayer *player;

@end

static CZMusicPlayer *_instance;

@implementation CZMusicPlayer

+ (instancetype)sharePlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CZMusicPlayer alloc] init];
    });
    return _instance;
}

- (BOOL)playWithMusic:(CZMusic *)music
{
    // 获取文件URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.mp3 withExtension:nil];
    if ( !url) {
        NSLog(@"没有这首歌");
        return NO;
    }
    
    // 如果不是同一首歌, 创建
    if ( ![self.player.url isEqual:url]) {
        // 创建player
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 准备播放音乐
        [self.player prepareToPlay];
    }

    // 播放音乐
    return [self.player play];
}

- (void)pause
{
    if ([self.player isPlaying]) {
        [self.player pause];
    }
}

-(void)stop
{
    if (self.player) {
        [self.player stop];
        self.player = nil;
    }
}

#pragma mark - Getter & Setter

- (NSTimeInterval)currentTime
{
    if ( !self.player) {
        return 0.0;
    }
    return self.player.currentTime;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    self.player.currentTime = currentTime;
}

- (NSTimeInterval)duration
{
    if ( !self.player) {
        return 0.0;
    }
    return self.player.duration;
}

- (BOOL)isPlaying
{
    return self.player.isPlaying;
}

@end














