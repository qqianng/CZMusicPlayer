//
//  CZMusicPlayer.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CZMusic.h"

@interface CZMusicPlayer : NSObject

+ (instancetype)sharePlayer;
//只有播放和暂停状态时player才有值。
@property (strong, nonatomic, readonly) AVAudioPlayer *player;

/**
 *  播放指定music模型的音乐
 */
- (BOOL)playWithMusic:(CZMusic *)music;

// 暂停音乐
- (void)pause;

// 停止音乐
- (void)stop;

// 当前时间
@property (assign, nonatomic) NSTimeInterval currentTime;

// 音乐时长
@property (assign, nonatomic, readonly) NSTimeInterval duration;

// 是否正在播放
@property (assign, nonatomic, getter=isPlaying) BOOL playing;

@end
