//
//  CZMusicPlayerVC.h
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "CZMusic.h"
#import "CZMusicPlayer.h"
#import "CZMusicTool.h"
#import "CZLyricsParser.h"
#import "CZLyrics.h"
#import "CZLabel.h"

//歌词高亮时的颜色
#define CZLyricsHighlightedColor [UIColor cyanColor]

@interface CZMusicPlayerVC : UIViewController

//播放音乐
- (void)playMusic:(CZMusic *)music;
//暂停播放音乐
- (void)pause;
//是否正在播放
- (BOOL)isPlaying;

//音乐列表
@property (strong, nonatomic) NSArray *musicList;
//当前音乐模型
@property (strong, nonatomic) CZMusic *currentMusic;


@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;


@end
